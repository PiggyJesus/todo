import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:todo/presentation/pages/add_page/add_page.dart';
import 'package:todo/presentation/bloc/tasks_bloc.dart';
import 'package:todo/domain/models/importance.dart';
import 'package:todo/presentation/utils/my_colors.dart';
import 'package:todo/presentation/utils/my_icons.dart';
import 'package:todo/presentation/utils/my_text_styles.dart';
import 'package:todo/domain/models/task_model.dart';

class TaskWidget extends StatefulWidget {
  final int id;

  const TaskWidget(this.id, {super.key});

  @override
  State<TaskWidget> createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget> {
  late final TasksBloc tasksBloc;
  double offset = 0;

  @override
  void initState() {
    super.initState();
    tasksBloc = BlocProvider.of<TasksBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(tasksBloc.data[widget.id]),
      background: LeftShift(offset),
      secondaryBackground: RightShift(offset),
      child: MainPart(tasksBloc.data[widget.id].copyWith(), widget.id),
      onUpdate: (details) {
        setState(() {
          offset = details.progress;
        });
      },
      confirmDismiss: (direction) {
        if (direction == DismissDirection.endToStart) {
          tasksBloc.add(TaskDeleteEvent(widget.id));
        } else {
          tasksBloc.add(TaskUpdateEvent(
            tasksBloc.data[widget.id]
                .copyWith(isDone: !tasksBloc.data[widget.id].isDone),
            widget.id,
          ));
        }

        return Future<bool>.value(false);
      },
    );
  }
}

class MainPart extends StatefulWidget {
  final TaskModel task;
  final int id;
  const MainPart(this.task, this.id, {super.key});

  @override
  State<MainPart> createState() => _MainPartState();
}

class _MainPartState extends State<MainPart> {
  late TaskModel task;

  @override
  void initState() {
    super.initState();
    task = widget.task;
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      titleAlignment: ListTileTitleAlignment.top,
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => (AddPage(widget.id)),
            ));
      },
      leading: SizedBox(
        width: (task.isDone || task.importance == Importance.common) ? 50 : 60,
        child: Row(
          children: [
            Checkbox(
              splashRadius: 2,
              value: task.isDone,
              fillColor: MaterialStateProperty.resolveWith<Color>(
                  (Set<MaterialState> states) {
                if (states.contains(MaterialState.selected)) {
                  return MyColors.green;
                }
                return task.importance == Importance.high
                    ? MyColors.red
                    : MyColors.separator;
              }),
              onChanged: (value) {
                setState(() {
                  task.isDone = value!;
                  BlocProvider.of<TasksBloc>(context)
                      .add(TaskUpdateEvent(task.copyWith(), widget.id));
                });
              },
            ),
            if (!task.isDone && task.importance == Importance.high)
              SvgPicture.asset(
                MyIcons.double_excl,
                color: MyColors.red,
              ),
            if (!task.isDone && task.importance == Importance.low)
              SvgPicture.asset(
                MyIcons.down_arrow,
                color: MyColors.grey,
              ),
          ],
        ),
      ),
      trailing: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: SvgPicture.asset(
          MyIcons.info,
          color: MyColors.labelTertiary, // переделать цвет
        ),
      ),
      title: Text(
        widget.task.name,
        maxLines: 3,
        style: task.isDone
            ? MyTextStyles.subhead.copyWith(
                color: MyTextStyles.subhead.color!.withOpacity(0.3),
                decoration: TextDecoration.lineThrough,
              )
            : MyTextStyles.body,
      ),
      subtitle: (task.doUntil == null)
          ? null
          : Text(
              DateFormat('dd.MM.yyyy').format(task.doUntil!),
              style: MyTextStyles.subhead.copyWith(
                color: MyTextStyles.subhead.color!.withOpacity(0.3),
              ),
            ),
    );
  }
}

class LeftShift extends StatelessWidget {
  final double offset;
  LeftShift(this.offset, {super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final iconWidth = 18 / 360 * width;
    final iconPadding = iconWidth * 1.5;
    final fullIcon = iconWidth + iconPadding * 2;
    final iconPart = fullIcon / width;
    final flexLeft = max(offset - iconPart, 0) + iconPadding / width;
    final flexRight = min(1 - iconPart, 1 - offset) + iconPadding / width;

    return Container(
      color: MyColors.green,
      child: Row(
        children: [
          Spacer(flex: (flexLeft * 10000).round() + 1),
          SvgPicture.asset(
            MyIcons.check,
            color: MyColors.white,
            width: iconWidth,
          ),
          Spacer(flex: (flexRight * 10000).round() + 1),
        ],
      ),
    );
  }
}

class RightShift extends StatelessWidget {
  final double offset;
  const RightShift(this.offset, {super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final iconWidth = 14 / 360 * width;
    final iconPadding = iconWidth * 2.1;
    final fullIcon = iconWidth + iconPadding * 2;
    final iconPart = fullIcon / width;
    final flexRight = max(offset - iconPart, 0) + iconPadding / width;
    final flexLeft = min(1 - iconPart, 1 - offset) + iconPadding / width;

    return Container(
      color: MyColors.red,
      child: Row(
        children: [
          Spacer(flex: (flexLeft * 10000).round() + 1),
          SvgPicture.asset(
            MyIcons.delete,
            color: MyColors.white,
            width: iconWidth,
          ),
          Spacer(flex: (flexRight * 10000).round() + 1),
        ],
      ),
    );
  }
}
