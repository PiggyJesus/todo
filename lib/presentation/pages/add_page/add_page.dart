// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_it/get_it.dart';
import 'package:todo/presentation/bloc/tasks_bloc/tasks_bloc.dart';
import 'package:todo/domain/models/importance.dart';
import 'package:todo/core/utils/my_colors.dart';
import 'package:todo/core/utils/my_icons.dart';
import 'package:todo/core/utils/my_text_styles.dart';
import 'package:todo/domain/models/task_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:intl/intl.dart';
import 'package:todo/presentation/navigation/my_navigator_repository.dart';
import 'package:uuid/uuid.dart';

class AddPage extends StatefulWidget {
  final String taskId;
  const AddPage({
    required this.taskId,
    super.key,
  });

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  final TextEditingController _textController = TextEditingController();
  late TaskModel task;
  late String taskId;
  final _formKey = GlobalKey<FormState>();
  late bool newTask;
  bool loaded = false;

  @override
  void initState() {
    super.initState();
    taskId = widget.taskId;
    newTask = taskId == '';
  }

  void _initTask() {
    TaskModel? mayBeTask =
        BlocProvider.of<TasksBloc>(context).data[widget.taskId];
    if (newTask || mayBeTask == null) {
      String uuid = const Uuid().v1();
      task = TaskModel(
        uuid: uuid,
        name: "",
        importance: Importance.common,
        changedAt: DateTime.now(),
        createdAt: DateTime.now(),
        lastUpdatedBy: "123",
      );
    } else {
      task = mayBeTask;
    }
    _textController.text = task.name;
    loaded = true;
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final myColors = GetIt.I<MyColors>();
    final myTextStyles = GetIt.I<MyTextStyles>();

    return BlocBuilder<TasksBloc, TasksState>(
      builder: (context, state) {
        if (state is! TasksLoadedState) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (!loaded) _initTask();

        return Form(
          key: _formKey,
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: myColors.primary,
              elevation: 0,
              scrolledUnderElevation: 6,
              leading: CloseButton(color: myColors.labelPrimary),
              actions: [
                TextButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      task = task.copyWith(
                        name: _textController.text,
                        changedAt: DateTime.now(),
                      );
                      if (newTask) {
                        BlocProvider.of<TasksBloc>(context)
                            .add(TaskInsertEvent(task));
                      } else {
                        BlocProvider.of<TasksBloc>(context)
                            .add(TaskUpdateEvent(task));
                      }
                      GetIt.I<MyNavigatorRepository>().navigateToTasksPage();
                    }
                  },
                  child: Text(
                    AppLocalizations.of(context)!.save,
                    style: myTextStyles.button.copyWith(color: myColors.blue),
                  ),
                ),
              ],
            ),
            backgroundColor: myColors.primary,
            body: ListView(
              children: [
                Container(
                  margin: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                  decoration: BoxDecoration(
                    color: myColors.secondary,
                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                    boxShadow: [
                      BoxShadow(
                        color: myColors.greyLight,
                        blurRadius: 1.0,
                        offset: const Offset(0, 1),
                      ),
                    ],
                  ),
                  constraints: const BoxConstraints(minHeight: 104),
                  child: TextFormField(
                    controller: _textController,
                    maxLines: null,
                    style: myTextStyles.body,
                    decoration: InputDecoration(
                      hintText: AppLocalizations.of(context)!.textExample,
                      hintStyle: myTextStyles.body.copyWith(
                          color: myColors.labelTertiary.withOpacity(0.3)),
                      contentPadding: const EdgeInsets.all(16),
                      border: InputBorder.none,
                    ),
                    validator: (value) {
                      return (value == null || value.isEmpty)
                          ? AppLocalizations.of(context)!.textErrorMessage
                          : null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Text(
                    AppLocalizations.of(context)!.priority,
                    style: myTextStyles.body,
                  ),
                ),
                DropdownButton<Importance>(
                  elevation: 16,
                  underline: const SizedBox(),
                  value: task.importance,
                  dropdownColor: myColors.elevated,
                  items: List.from([
                    DropdownMenuItem(
                      value: Importance.common,
                      child: Text(
                        AppLocalizations.of(context)!.withoutPriority,
                        style: myTextStyles.body.copyWith(
                            color: myColors.labelTertiary.withOpacity(0.3)),
                      ),
                    ),
                    DropdownMenuItem(
                      value: Importance.low,
                      child: Text(
                        AppLocalizations.of(context)!.lowPriority,
                        style: myTextStyles.body,
                      ),
                    ),
                    DropdownMenuItem(
                      value: Importance.high,
                      child: Text(
                        "!! ${AppLocalizations.of(context)!.highPriority}",
                        style: myTextStyles.body.copyWith(color: myColors.red),
                      ),
                    ),
                  ]),
                  onChanged: (Importance? value) {
                    setState(() {
                      task = task.copyWith(importance: value!);
                    });
                  },
                  iconSize: 0,
                  hint: Text(
                    AppLocalizations.of(context)!.doUntil,
                    style: myTextStyles.body.copyWith(
                      color: myTextStyles.body.color!.withOpacity(0.3),
                    ),
                  ),
                  padding: const EdgeInsets.only(left: 16),
                ),
                Divider(
                  color: myColors.separator,
                  thickness: 1,
                  endIndent: 16,
                  indent: 16,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
                  child: Row(
                    children: [
                      Column(
                        children: [
                          Text(
                            AppLocalizations.of(context)!.doUntil,
                            style: myTextStyles.body,
                          ),
                          if (task.deadline != null)
                            Text(
                              DateFormat(
                                'dd MMMM yyyy',
                                AppLocalizations.of(context)!.localeName,
                              ).format(task.deadline!),
                              style: myTextStyles.subhead
                                  .copyWith(color: myColors.blue),
                            ),
                        ],
                      ),
                      const Spacer(),
                      Switch(
                        overlayColor: MaterialStateProperty.resolveWith<Color>(
                            (Set<MaterialState> states) {
                          if (states.contains(MaterialState.selected)) {
                            return myColors.blue;
                          }
                          return myColors.secondary;
                        }),
                        value: task.deadline != null,
                        onChanged: (value) async {
                          if (value) {
                            final newDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime.now(),
                              lastDate: DateTime(3000),
                            );

                            if (newDate != null) {
                              setState(() {
                                task = task.copyWith(deadline: newDate);
                              });
                            }
                          } else {
                            setState(() {
                              task = task.copyWith(deadline: null);
                            });
                          }
                        },
                      ),
                    ],
                  ),
                ),
                Divider(
                  color: myColors.separator,
                  thickness: 1,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, top: 23, bottom: 20),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: TextButton(
                      style: TextButton.styleFrom(
                        fixedSize: const Size(115, 36),
                        padding: const EdgeInsets.symmetric(
                            vertical: 4, horizontal: 10),
                      ),
                      onPressed: newTask
                          ? null
                          : () {
                              BlocProvider.of<TasksBloc>(context)
                                  .add(TaskDeleteEvent(widget.taskId));
                              GetIt.I<MyNavigatorRepository>()
                                  .navigateToTasksPage();
                            },
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            MyIcons.delete,
                            color:
                                newTask ? myColors.labelDisable : myColors.red,
                          ),
                          const SizedBox(width: 15),
                          Text(
                            AppLocalizations.of(context)!.delete,
                            style: myTextStyles.body.copyWith(
                              color: newTask
                                  ? myColors.labelDisable
                                  : myColors.red,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
