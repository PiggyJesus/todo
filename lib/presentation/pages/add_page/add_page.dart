import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:todo/presentation/bloc/tasks_bloc.dart';
import 'package:todo/domain/models/importance.dart';
import 'package:todo/presentation/utils/my_colors.dart';
import 'package:todo/presentation/utils/my_icons.dart';
import 'package:todo/presentation/utils/my_text_styles.dart';
import 'package:todo/domain/models/task_model.dart';

import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

class AddPage extends StatefulWidget {
  final int taskId;
  const AddPage(this.taskId, {super.key});

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  final TextEditingController _textController = TextEditingController();
  late TaskModel task;
  late int taskId;
  final _formKey = GlobalKey<FormState>();
  late bool newTask;

  @override
  void initState() {
    super.initState();
    taskId = widget.taskId;
    newTask = taskId == -1;
    if (newTask) {
      String uuid = const Uuid().v1();
      task = TaskModel(uuid: uuid, name: "", importance: Importance.common);
    } else {
      task = BlocProvider.of<TasksBloc>(context).data[widget.taskId].copyWith();
    }
    _textController.text = task.name;
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          scrolledUnderElevation: 6,
          leading: const CloseButton(color: MyColors.labelPrimary),
          actions: [
            TextButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  task.name = _textController.text;
                  if (newTask) {
                    BlocProvider.of<TasksBloc>(context)
                        .add(TaskInsertEvent(task));
                  } else {
                    BlocProvider.of<TasksBloc>(context)
                        .add(TaskUpdateEvent(task, widget.taskId));
                  }
                  Navigator.pop(context);
                }
              },
              child: Text(
                "СОХРАНИТЬ",
                style: MyTextStyles.button.copyWith(color: MyColors.blue),
              ),
            ),
          ],
        ),
        backgroundColor: MyColors.primary,
        body: ListView(
          children: [
            Container(
              margin: const EdgeInsets.fromLTRB(16, 8, 16, 16),
              decoration: const BoxDecoration(
                color: MyColors.secondary,
                borderRadius: BorderRadius.all(Radius.circular(8)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey, //New
                    blurRadius: 1.0,
                    offset: Offset(0, 1),
                  ),
                ],
              ),
              constraints: const BoxConstraints(minHeight: 104),
              child: TextFormField(
                controller: _textController,
                maxLines: null,
                decoration: InputDecoration(
                  hintText: "Что надо сделать…",
                  hintStyle: MyTextStyles.body
                      .copyWith(color: MyColors.labelTertiary.withOpacity(0.3)),
                  contentPadding: const EdgeInsets.all(16),
                  border: InputBorder.none,
                ),
                validator: (value) {
                  return (value == null || value.isEmpty)
                      ? "Введите название"
                      : null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Text(
                "Важность",
                style: MyTextStyles.body,
              ),
            ),
            DropdownButton<Importance>(
              elevation: 16,
              underline: const SizedBox(),
              value: task.importance,
              items: List.from([
                DropdownMenuItem(
                  value: Importance.common,
                  child: Text(
                    "Нет",
                    style: MyTextStyles.body.copyWith(
                        color: MyColors.labelTertiary.withOpacity(0.3)),
                  ),
                ),
                DropdownMenuItem(
                  value: Importance.low,
                  child: Text(
                    "Низкий",
                    style: MyTextStyles.body,
                  ),
                ),
                DropdownMenuItem(
                  value: Importance.high,
                  child: Text(
                    "!! Высокий",
                    style: MyTextStyles.body.copyWith(color: MyColors.red),
                  ),
                ),
              ]),
              onChanged: (Importance? value) {
                setState(() {
                  task.importance = value!;
                });
              },
              iconSize: 0,
              hint: Text(
                "Нет",
                style: MyTextStyles.body.copyWith(
                  color: MyTextStyles.body.color!.withOpacity(0.3),
                ),
              ),
              padding: const EdgeInsets.only(left: 16),
            ),
            const Divider(
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
                        "Сделать до",
                        style: MyTextStyles.body,
                      ),
                      if (task.doUntil != null)
                        Text(
                          DateFormat('dd.MM.yyyy').format(task.doUntil!),
                          style: MyTextStyles.subhead
                              .copyWith(color: MyColors.blue),
                        ),
                    ],
                  ),
                  const Spacer(),
                  Switch(
                    value: task.doUntil != null,
                    onChanged: (value) async {
                      if (value) {
                        final newDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(0),
                          lastDate: DateTime(3000),
                        );

                        if (newDate != null) {
                          setState(() {
                            task.doUntil = newDate;
                          });
                        }
                      } else {
                        setState(() {
                          task.doUntil = null;
                        });
                      }
                    },
                  ),
                ],
              ),
            ),
            const Divider(
              thickness: 1,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 23, bottom: 20),
              child: Align(
                alignment: Alignment.topLeft,
                child: TextButton(
                  style: TextButton.styleFrom(
                    fixedSize: const Size(115, 36),
                    padding:
                        const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
                  ),
                  onPressed: newTask
                      ? null
                      : () {
                          BlocProvider.of<TasksBloc>(context)
                              .add(TaskDeleteEvent(widget.taskId));
                          Navigator.pop(context);
                        },
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        MyIcons.delete,
                        color: newTask ? MyColors.labelDisable : MyColors.red,
                      ),
                      const SizedBox(width: 15),
                      Text(
                        "Удалить",
                        style: MyTextStyles.body.copyWith(
                          color: newTask ? MyColors.labelDisable : MyColors.red,
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
  }
}
