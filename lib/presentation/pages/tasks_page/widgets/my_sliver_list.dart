import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/presentation/bloc/tasks_bloc/tasks_bloc.dart';

import 'task_widget.dart';

class MySLiverList extends StatelessWidget {
  const MySLiverList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final tasksBloc = BlocProvider.of<TasksBloc>(context);
    final size = MediaQuery.of(context).size;
    int columnsCount = (size.width / size.height).floor();
    var data = tasksBloc.data.values.toList();
    if (!tasksBloc.visible) {
      data = data.where((element) => !element.done).toList();
    }

    if (columnsCount == 0) {
      return SliverList(
        delegate: SliverChildListDelegate(
          List.generate(
            data.length,
            (i) => SizedBox(
              height: size.width / 4,
              child: TaskWidget(
                task: data[i],
              ).paddingAll(8),
            ),
          ),
        ),
      );
    }

    return SliverGrid.count(
      crossAxisCount: columnsCount,
      childAspectRatio: 4,
      children: List.generate(
        data.length,
        (i) => TaskWidget(
          task: data[i],
        ).paddingAll(8),
      ),
    );
  }
}
