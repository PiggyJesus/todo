import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:todo/presentation/navigation/navigation_state.dart';
import 'package:todo/presentation/pages/add_page/add_page.dart';
import 'package:todo/presentation/pages/tasks_page/tasks_page.dart';

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
            onTapNewTask: _showNewTaskPage,
            onTapEditTask: _showEditTaskPage,
          ),
        ),
        if (state?.isNewTaskPage ?? false)
          const MaterialPage(
            child: AddPage(-1),
          ),
        if (state?.isEditTaskPage ?? false)
          MaterialPage(
            child: AddPage(state!.selectedTaskId!),
          ),
        // if (state?.isUnknown ?? false)
        //   MaterialPage(child: UnknownPage()),
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
    state = configuration;
    notifyListeners();
  }

  void _showNewTaskPage() {
    state = NavigationState.newTask();
    notifyListeners();
  }

  void _showEditTaskPage(int selectedTaskId) {
    state = NavigationState.editTask(selectedTaskId);
    notifyListeners();
  }
}
