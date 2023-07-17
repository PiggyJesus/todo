import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:todo/data/local/servise/local_service.dart';
import 'package:todo/data/local/unit/local_unit.dart';
import 'package:todo/data/remote/unit/remote_unit.dart';
import 'package:todo/data/repository/repository.dart';
import 'package:todo/domain/models/enviroment.dart';
import 'package:todo/domain/repository/task_repository.dart';
import 'package:todo/firebase_options.dart';
import 'package:todo/presentation/bloc/importance_color_bloc/importance_color_bloc.dart';
import 'package:todo/presentation/bloc/tasks_bloc/tasks_bloc.dart';
import 'package:todo/presentation/my_app_wrapper.dart';
import 'package:todo/presentation/navigation/my_navigator_impl.dart';
import 'package:todo/presentation/navigation/my_navigator_repository.dart';
import 'package:todo/presentation/navigation/route_information_parser.dart';
import 'package:todo/presentation/navigation/router_delegate.dart';
import '../test/data/local_servise_mock.dart';
import '../test/data/remote_unit_mock.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _initDependencies(Enviroment.test);
  runApp(const MyAppWrapper());
}

Future<void> _initDependencies(Enviroment env) async {
  GetIt.I.registerSingleton<Enviroment>(env);

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // зависимости локальной бд
  GetIt.I.registerSingleton<LocalService>(LocalServiseMock());
  GetIt.I.registerSingleton(LocalUnit(GetIt.I<LocalService>()));

  // зависимости удаленной бд
  GetIt.I.registerSingleton<RemoteUnit>(RemoteUnitMock());

  // общий репозиторий хранилища
  GetIt.I.registerSingleton<TaskRepository>(TaskRepositoryImpl(
    localUnit: GetIt.I<LocalUnit>(),
    remoteUnit: GetIt.I<RemoteUnit>(),
  ));

  // блок на основе репозитория
  GetIt.I.registerSingleton(TasksBloc(GetIt.I<TaskRepository>()));

  final colorBloc = ColorBloc();
  GetIt.I.registerSingleton<ColorBloc>(colorBloc);

  //Навигация
  GetIt.I.registerSingleton(MyRouteInformationParser());
  GetIt.I.registerSingleton(MyRouterDelegate());

  GetIt.I.registerSingleton<MyNavigatorRepository>(
    MyNavigatorImpl(routerDelegate: GetIt.I<MyRouterDelegate>()),
  );
 }
