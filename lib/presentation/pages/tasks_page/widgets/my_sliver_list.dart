import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/presentation/bloc/tasks_bloc.dart';
import 'package:todo/presentation/navigation/navigation_state.dart';

import 'task_widget.dart';

class MySLiverList extends StatelessWidget {
  final void Function(NavigationState) onTapNavigate;
  const MySLiverList({
    required this.onTapNavigate,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final tasksBloc = BlocProvider.of<TasksBloc>(context);
    return SliverList(
      delegate: SliverChildListDelegate([
        Card(
          margin: const EdgeInsets.all(8),
          clipBehavior: Clip.hardEdge,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(
              tasksBloc.data.length,
              (i) =>
                  (!tasksBloc.visible && tasksBloc.data.values.toList()[i].done)
                      ? const SizedBox()
                      : TaskWidget(
                          task: tasksBloc.data.values.toList()[i],
                          onTapNavigate: onTapNavigate,
                        ),
            ),
          ),
        ),
      ]),
    );
  }
}
