import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:todo/domain/models/enviroment.dart';
import 'package:todo/presentation/navigation/navigation_state.dart';
import 'package:todo/presentation/pages/add_page/add_page.dart';
import 'package:todo/presentation/pages/tasks_page/tasks_page.dart';
import 'package:todo/presentation/pages/unknown_page/unknown_page.dart';

class MyRouterDelegate extends RouterDelegate<NavigationState>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<NavigationState> {
  @override
  final GlobalKey<NavigatorState> navigatorKey;

  MyRouterDelegate() : navigatorKey = GlobalKey<NavigatorState>();

  NavigationState? state;

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      pages: [
        MaterialPage(
          child: TasksPage(
            onTapNavigate: setNewRoutePath,
            enviroment: GetIt.I<Enviroment>(),
          ),
        ),
        if (state?.isNewTaskPage ?? false)
          MaterialPage(
            child: AddPage(
              taskId: '',
              onTapNavigate: setNewRoutePath,
            ),
          ),
        if (state?.isEditTaskPage ?? false)
          MaterialPage(
            child: AddPage(
              taskId: state!.selectedTaskId!,
              onTapNavigate: setNewRoutePath,
            ),
          ),
        if (state?.isUnknown ?? false) const MaterialPage(child: UnknownPage()),
      ],
      onPopPage: (route, result) {
        if (!route.didPop(result)) {
          return false;
        }

        state = NavigationState.root();

        notifyListeners();
        return true;
      },
    );
  }

  @override
  Future<void> setNewRoutePath(NavigationState configuration) async {
    if (configuration.isRoot) {
      FirebaseAnalytics.instance.logEvent(name: "go_to_main_page");
    } else if (configuration.isEditTaskPage || configuration.isNewTaskPage) {
      FirebaseAnalytics.instance.logEvent(name: "go_to_add_page");
    }
    state = configuration;
    notifyListeners();
  }
}
