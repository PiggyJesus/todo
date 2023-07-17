import 'package:todo/presentation/navigation/my_navigator_repository.dart';
import 'package:todo/presentation/navigation/navigation_state.dart';
import 'package:todo/presentation/navigation/router_delegate.dart';

class MyNavigatorImpl implements MyNavigatorRepository {
  late final MyRouterDelegate _routerDelegate;

  MyNavigatorImpl({required MyRouterDelegate routerDelegate})
      : _routerDelegate = routerDelegate;

  @override
  void navigateToEditTaskPage(String uuid) {
    _routerDelegate.setNewRoutePath(NavigationState.editTask(uuid));
  }

  @override
  void navigateToNewTaskPage() {
    _routerDelegate.setNewRoutePath(NavigationState.newTask());
  }

  @override
  void navigateToTasksPage() {
    _routerDelegate.setNewRoutePath(NavigationState.root());
  }
}
