import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/l10n/l10n.dart';
import 'package:todo/presentation/bloc/tasks_bloc.dart';
import 'package:todo/presentation/utils/my_colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'pages/tasks_page/tasks_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TasksBloc()
        // ..add(TaskInsertEvent(TaskModel(
        //   uuid: '1',
        //   name:
        //       "t t t t t t t t t t t t t t t t t t t t t t t t t t t t t t t t t t t t t ",
        //   importance: Importance.high,
        // )))
        // ..add(TaskInsertEvent(TaskModel(
        //   uuid: '2',
        //   name: "task2",
        //   importance: Importance.low,
        // )))
        // ..add(TaskInsertEvent(TaskModel(
        //   uuid: '3',
        //   name: "task3",
        //   importance: Importance.common,
        // )))
        ,
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
            primarySwatch: Colors.blue,
            backgroundColor: MyColors.primary,
            appBarTheme: const AppBarTheme(
              backgroundColor: MyColors.primary,
            )),
        home: const TasksPage(),
        debugShowCheckedModeBanner: false,
        supportedLocales: L10n.all,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
      ),
    );
  }
}
