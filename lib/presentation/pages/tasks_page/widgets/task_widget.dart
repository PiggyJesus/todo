// ignore_for_file: deprecated_member_use

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:todo/presentation/bloc/tasks_bloc.dart';
import 'package:todo/domain/models/importance.dart';
import 'package:todo/core/utils/my_colors.dart';
import 'package:todo/core/utils/my_icons.dart';
import 'package:todo/core/utils/my_text_styles.dart';
import 'package:todo/domain/models/task_model.dart';
import 'package:todo/presentation/navigation/navigation_state.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TaskWidget extends StatefulWidget {
  final TaskModel task;
  final void Function(NavigationState) onTapNavigate;

  const TaskWidget({
    required this.task,
    required this.onTapNavigate,
    super.key,
  });

  @override
  State<TaskWidget> createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget> {
  double offset = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TasksBloc, TasksState>(builder: (context, state) {
      final tasksBloc = BlocProvider.of<TasksBloc>(context);
      if (!tasksBloc.visible && widget.task.done) {
        return const SizedBox();
      }
      return Dismissible(
        key: ValueKey(widget.task),
        background: LeftShift(offset),
        secondaryBackground: RightShift(offset),
        child: MainPart(
          task: widget.task,
          onTapNavigate: widget.onTapNavigate,
        ),
        onUpdate: (details) {
          setState(() {
            offset = details.progress;
          });
        },
        confirmDismiss: (direction) {
          if (direction == DismissDirection.endToStart) {
            tasksBloc.add(TaskDeleteEvent(widget.task.uuid));
          } else {
            tasksBloc.add(TaskUpdateEvent(
              widget.task.copyWith(done: !widget.task.done),
            ));
          }

          return Future<bool>.value(false);
        },
      );
    });
  }
}

class MainPart extends StatefulWidget {
  final void Function(NavigationState) onTapNavigate;
  final TaskModel task;
  const MainPart({
    required this.task,
    required this.onTapNavigate,
    super.key,
  });

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
      tileColor: MyColors.secondary,
      titleAlignment: ListTileTitleAlignment.top,
      onTap: () {
        widget.onTapNavigate(NavigationState.editTask(task.uuid));
      },
      leading: SizedBox(
        width: (task.done || task.importance == Importance.common) ? 50 : 60,
        child: Row(
          children: [
            Checkbox(
              splashRadius: 2,
              value: task.done,
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
                  task = task.copyWith(
                    done: value!,
                    changedAt: DateTime.now(),
                  );
                  BlocProvider.of<TasksBloc>(context)
                      .add(TaskUpdateEvent(task.copyWith()));
                });
              },
            ),
            if (!task.done && task.importance == Importance.high)
              SvgPicture.asset(
                MyIcons.doubleExcl,
                color: MyColors.red,
              ),
            if (!task.done && task.importance == Importance.low)
              SvgPicture.asset(
                MyIcons.downArrow,
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
        overflow: TextOverflow.ellipsis,
        style: task.done
            ? MyTextStyles.body.copyWith(
                color: MyTextStyles.subhead.color!.withOpacity(0.3),
                decoration: TextDecoration.lineThrough,
              )
            : MyTextStyles.body,
      ),
      subtitle: (task.deadline == null)
          ? null
          : Text(
              DateFormat(
                'dd MMMM yyyy',
                AppLocalizations.of(context)!.localeName,
              ).format(task.deadline!),
              style: MyTextStyles.subhead.copyWith(
                color: MyTextStyles.subhead.color!.withOpacity(0.3),
              ),
            ),
    );
  }
}

class LeftShift extends StatelessWidget {
  final double offset;
  const LeftShift(this.offset, {super.key});

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
