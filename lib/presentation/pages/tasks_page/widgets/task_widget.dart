// ignore_for_file: deprecated_member_use

import 'dart:math';

import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:todo/presentation/bloc/importance_color_bloc/importance_color_bloc.dart';
import 'package:todo/presentation/bloc/tasks_bloc/tasks_bloc.dart';
import 'package:todo/domain/models/importance.dart';
import 'package:todo/core/utils/my_colors.dart';
import 'package:todo/core/utils/my_icons.dart';
import 'package:todo/core/utils/my_text_styles.dart';
import 'package:todo/domain/models/task_model.dart';
import 'package:todo/presentation/navigation/my_navigator_repository.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TaskWidget extends StatefulWidget {
  final TaskModel task;

  const TaskWidget({
    required this.task,
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
  final TaskModel task;
  const MainPart({
    required this.task,
    super.key,
  });

  @override
  State<MainPart> createState() => _MainPartState();
}

class _MainPartState extends State<MainPart> {
  late TaskModel task;
  late final MyColors myColors;
  late final MyTextStyles myTextStyles;

  @override
  void initState() {
    super.initState();
    task = widget.task;
    myColors = GetIt.I<MyColors>();
    myTextStyles = GetIt.I<MyTextStyles>();
  }

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<ColorBloc, ColorState>(builder: (context, state) {
        var highImportanceColor = myColors.red;
        if (state is ColorLoadedState) {
          if (state.color == ImportanceColor.purple) {
            highImportanceColor = myColors.purple;
          }
        }

        return Container(
          color: myColors.secondary,
          child: GestureDetector(
            onTap: () {
              GetIt.I<MyNavigatorRepository>()
                  .navigateToEditTaskPage(task.uuid);
            },
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                10.widthBox,
                Checkbox(
                  splashRadius: 2,
                  value: task.done,
                  fillColor: MaterialStateProperty.resolveWith<Color>(
                      (Set<MaterialState> states) {
                    if (states.contains(MaterialState.selected)) {
                      return myColors.green;
                    }
                    return task.importance == Importance.high
                        ? highImportanceColor
                        : myColors.separator;
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
                if (!task.done && task.importance != Importance.common)
                  10.widthBox,
                if (!task.done && task.importance == Importance.high)
                  SvgPicture.asset(
                    MyIcons.doubleExcl,
                    color: highImportanceColor,
                  ),
                if (!task.done && task.importance == Importance.low)
                  SvgPicture.asset(
                    MyIcons.downArrow,
                    color: myColors.grey,
                  ),
                10.widthBox,
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.task.name,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: task.done
                          ? myTextStyles.body.copyWith(
                              color:
                                  myTextStyles.subhead.color!.withOpacity(0.3),
                              decoration: TextDecoration.lineThrough,
                            )
                          : myTextStyles.body,
                    ),
                    if (task.deadline != null)
                      Text(
                        DateFormat(
                          'dd MMMM yyyy',
                          AppLocalizations.of(context)!.localeName,
                        ).format(task.deadline!),
                        style: myTextStyles.subhead.copyWith(
                          color: myTextStyles.subhead.color!.withOpacity(0.3),
                        ),
                      ),
                  ],
                ).expanded(),
                SvgPicture.asset(
                  MyIcons.info,
                  color: myColors.labelTertiary, // переделать цвет
                ).paddingSymmetric(horizontal: 20),
              ],
            ),
          ),
        );
      });
}

class LeftShift extends StatelessWidget {
  final double offset;
  const LeftShift(this.offset, {super.key});

  @override
  Widget build(BuildContext context) {
    final myColors = GetIt.I<MyColors>();

    final width = MediaQuery.of(context).size.width;
    final iconWidth = 18 / 360 * width;
    final iconPadding = iconWidth * 1.5;
    final fullIcon = iconWidth + iconPadding * 2;
    final iconPart = fullIcon / width;
    final flexLeft = max(offset - iconPart, 0) + iconPadding / width;
    final flexRight = min(1 - iconPart, 1 - offset) + iconPadding / width;

    return Container(
      color: myColors.green,
      child: Row(
        children: [
          Spacer(flex: (flexLeft * 10000).round() + 1),
          SvgPicture.asset(
            MyIcons.check,
            color: myColors.white,
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
    final myColors = GetIt.I<MyColors>();

    final width = MediaQuery.of(context).size.width;
    final iconWidth = 14 / 360 * width;
    final iconPadding = iconWidth * 2.1;
    final fullIcon = iconWidth + iconPadding * 2;
    final iconPart = fullIcon / width;
    final flexRight = max(offset - iconPart, 0) + iconPadding / width;
    final flexLeft = min(1 - iconPart, 1 - offset) + iconPadding / width;

    return Container(
      color: myColors.red,
      child: Row(
        children: [
          Spacer(flex: (flexLeft * 10000).round() + 1),
          SvgPicture.asset(
            MyIcons.delete,
            color: myColors.white,
            width: iconWidth,
          ),
          Spacer(flex: (flexRight * 10000).round() + 1),
        ],
      ),
    );
  }
}
