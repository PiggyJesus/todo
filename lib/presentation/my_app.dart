import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/presentation/bloc/tasks_bloc.dart';
import 'package:todo/presentation/utils/importance.dart';
import 'package:todo/presentation/utils/my_colors.dart';
import 'package:todo/presentation/utils/task_model.dart';

import 'pages/tasks_page/tasks_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TasksBloc()
        ..add(TaskInsertEvent(TaskModel(
          name:
              "t t t t t t t t t t t t t t t t t t t t t t t t t t t t t t t t t t t t t ",
          importance: Importance.high,
        )))
        ..add(TaskInsertEvent(TaskModel(
          name: "task2",
          importance: Importance.low,
        )))
        ..add(TaskInsertEvent(TaskModel(
          name: "task3",
          importance: Importance.common,
        ))),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
            primarySwatch: Colors.blue,
            backgroundColor: MyColors.primary,
            textTheme: TextTheme(),
            appBarTheme: AppBarTheme(
              backgroundColor: MyColors.primary,
            )),
        home: TasksPage(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
