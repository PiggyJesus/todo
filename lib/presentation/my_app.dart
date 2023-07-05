import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:todo/data/local/servise/local_service.dart';
import 'package:todo/data/local/unit/local_unit.dart';
import 'package:todo/data/remote/servise/remote_service.dart';
import 'package:todo/data/remote/unit/remote_unit.dart';
import 'package:todo/data/repository/repository.dart';
import 'package:todo/l10n/l10n.dart';
import 'package:todo/presentation/bloc/tasks_bloc.dart';
import 'package:todo/core/utils/my_colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:todo/presentation/navigation/route_information_parser.dart';
import 'package:todo/presentation/navigation/router_delegate.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _myRouterDelegate = MyRouterDelegate();
  final _myRouteInformationParser = MyRouteInformationParser();

  @override
  void initState() {
    super.initState();

    // зависимости локальной бд
    GetIt.I.registerSingleton(LocalService());
    GetIt.I.registerSingleton(LocalUnit(GetIt.I<LocalService>()));

    // зависимости удаленной бд
    GetIt.I.registerSingleton(RemoteService());
    GetIt.I.registerSingleton(RemoteUnit(GetIt.I<RemoteService>()));

    // общий репозиторий хранилища
    GetIt.I.registerSingleton(Repository(
      localUnit: GetIt.I<LocalUnit>(),
      remoteUnit: GetIt.I<RemoteUnit>(),
    ));

    // блок на основе репозитория
    GetIt.I.registerSingleton(TasksBloc(GetIt.I<Repository>()));
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) => MaterialApp.router(
        routerDelegate: _myRouterDelegate,
        routeInformationParser: _myRouteInformationParser,
        builder: (context, child) {
          return BlocProvider(
            create: (_) => GetIt.I<TasksBloc>(),
            child: child,
          );
        },
        theme: ThemeData(
            primarySwatch: Colors.blue,
            backgroundColor: MyColors.primary,
            appBarTheme: const AppBarTheme(
              backgroundColor: MyColors.primary,
            )),
        debugShowCheckedModeBanner: false,
        supportedLocales: L10n.all,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
      );
}
