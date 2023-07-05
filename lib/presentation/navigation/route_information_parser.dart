import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:todo/presentation/bloc/tasks_bloc.dart';
import 'package:todo/presentation/navigation/navigation_state.dart';

class MyRouteInformationParser extends RouteInformationParser<NavigationState> {
  static const String _editPageRoute = "edit_page";

  @override
  Future<NavigationState> parseRouteInformation(
      RouteInformation routeInformation) async {
    print(
        '-------------------------${routeInformation.location}--------------------------');
    final location = routeInformation.location;
    if (location == null) {
      return NavigationState.unknown();
    }

    final uri = Uri.parse(location);
    if (uri.pathSegments.isEmpty) {
      return NavigationState.root();
    }

    if (uri.pathSegments.length == 1 ||
        uri.pathSegments.length == 2 && uri.pathSegments[1] == '') {
      if (uri.pathSegments[0] == _editPageRoute) {
        return NavigationState.newTask();
      }

      return NavigationState.root();
    }

    if (uri.pathSegments.length == 2 ||
        uri.pathSegments.length == 3 && uri.pathSegments[2] == '') {
      if (uri.pathSegments[0] == _editPageRoute) {
        final taskId = uri.pathSegments[1];
        if (GetIt.I<TasksBloc>().data.containsKey(taskId)) {
          return NavigationState.editTask(taskId);
        } else {
          return NavigationState.unknown();
        }
      }

      return NavigationState.unknown();
    }
    return NavigationState.root();
  }

  @override
  RouteInformation? restoreRouteInformation(NavigationState configuration) {
    if (configuration.isNewTaskPage) {
      return const RouteInformation(location: '/$_editPageRoute');
    }

    if (configuration.isEditTaskPage) {
      return RouteInformation(
          location: '/$_editPageRoute/${configuration.selectedTaskId}');
    }

    if (configuration.isUnknown) {
      return null;
    }

    return const RouteInformation(location: '/');
  }
}
