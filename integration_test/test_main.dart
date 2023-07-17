import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:todo/data/local/servise/local_service.dart';
import 'package:todo/data/local/unit/local_unit.dart';
import 'package:todo/data/remote/unit/remote_unit.dart';
import 'package:todo/data/repository/repository.dart';
import 'package:todo/domain/repository/task_repository.dart';
import 'package:todo/presentation/bloc/importance_color_bloc/importance_color_bloc.dart';
import 'package:todo/presentation/bloc/tasks_bloc/tasks_bloc.dart';
import 'package:todo/presentation/my_app_wrapper.dart';
import '../test/data/local_servise_mock.dart';
import '../test/data/remote_unit_mock.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _initDependencies();
  runApp(const MyAppWrapper(message: "TEST"));
}

Future<void> _initDependencies() async {
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
}