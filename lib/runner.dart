import 'dart:io';
import 'dart:ui';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:todo/domain/models/enviroment.dart';
import 'package:todo/domain/repository/task_repository.dart';
import 'package:todo/firebase_options.dart';
import 'package:todo/presentation/bloc/importance_color_bloc/importance_color_bloc.dart';
import 'package:todo/presentation/bloc/tasks_bloc/tasks_bloc.dart';
import 'package:todo/data/local/servise/local_service.dart';
import 'package:todo/data/local/unit/local_unit.dart';
import 'package:todo/data/remote/servise/remote_service.dart';
import 'package:todo/data/remote/unit/remote_unit.dart';
import 'package:todo/data/repository/repository.dart';
import 'package:todo/presentation/my_app_wrapper.dart';
import 'package:todo/presentation/navigation/my_navigator_impl.dart';
import 'package:todo/presentation/navigation/my_navigator_repository.dart';
import 'package:todo/presentation/navigation/route_information_parser.dart';
import 'package:todo/presentation/navigation/router_delegate.dart';

void run(Enviroment env) async {
  WidgetsFlutterBinding.ensureInitialized();
  await _initDependencies(env);

  runApp(const MyAppWrapper());
}

Future<void> _initDependencies(Enviroment env) async {
  // Тип сборки
  GetIt.I.registerSingleton<Enviroment>(env);

  // зависимости локальной бд
  GetIt.I.registerSingleton(LocalService());
  GetIt.I.registerSingleton(LocalUnit(GetIt.I<LocalService>()));

  // зависимости удаленной бд
  GetIt.I.registerSingleton(RemoteService());
  GetIt.I.registerSingleton(RemoteUnit(GetIt.I<RemoteService>()));

  // общий репозиторий хранилища
  GetIt.I.registerSingleton<TaskRepository>(TaskRepositoryImpl(
    localUnit: GetIt.I<LocalUnit>(),
    remoteUnit: GetIt.I<RemoteUnit>(),
  ));

  // Конфиг с цветом
  final colorBloc = ColorBloc();
  GetIt.I.registerSingleton<ColorBloc>(colorBloc);

  FirebaseAnalytics? analytics;

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  try {
    final result = await InternetAddress.lookup('example.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      analytics = FirebaseAnalytics.instance;

      final remoteConfig = FirebaseRemoteConfig.instance;
      await remoteConfig.setConfigSettings(RemoteConfigSettings(
        fetchTimeout: const Duration(minutes: 1),
        minimumFetchInterval: const Duration(hours: 1),
      ));

      await remoteConfig.fetchAndActivate();
      colorBloc
          .add(ColorUpdateEvent(remoteConfig.getString("importance_color")));

      remoteConfig.onConfigUpdated.listen((event) async {
        await remoteConfig.activate();
        final color = remoteConfig.getString("importance_color");
        colorBloc.add(ColorUpdateEvent(color));
      });

      // Ошибки
      FlutterError.onError = (errorDetails) {
        FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
      };
      PlatformDispatcher.instance.onError = (error, stack) {
        FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
        return true;
      };
    }
  } on SocketException catch (_) {}

  //Навигация
  GetIt.I.registerSingleton(MyRouteInformationParser());
  GetIt.I.registerSingleton(MyRouterDelegate(analytics: analytics));

  GetIt.I.registerSingleton<MyNavigatorRepository>(
    MyNavigatorImpl(routerDelegate: GetIt.I<MyRouterDelegate>()),
  );

  // блок на основе репозитория
  GetIt.I.registerSingleton(TasksBloc(
    GetIt.I<TaskRepository>(),
    analyticsInstance: analytics,
  ));
}
