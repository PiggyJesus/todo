import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/presentation/bloc/tasks_bloc.dart';

import 'task_widget.dart';

class MySLiverList extends StatelessWidget {
  final void Function(int selectedTaskId) onTapEditTask;
  const MySLiverList({
    required this.onTapEditTask,
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
              (i) => (!tasksBloc.visible && tasksBloc.data[i].done)
                  ? const SizedBox()
                  : TaskWidget(id: i, onTapEditTask: onTapEditTask),
            ),
          ),
        ),
      ]),
    );
  }
}
