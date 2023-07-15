import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:todo/core/utils/my_colors.dart';
import 'package:todo/core/utils/my_text_styles.dart';
import 'package:todo/l10n/l10n.dart';
import 'package:todo/presentation/bloc/tasks_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:todo/presentation/navigation/route_information_parser.dart';
import 'package:todo/presentation/navigation/router_delegate.dart';

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final _myRouterDelegate = MyRouterDelegate();

  final _myRouteInformationParser = MyRouteInformationParser();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) => MaterialApp.router(
        routerDelegate: _myRouterDelegate,
        routeInformationParser: _myRouteInformationParser,
        builder: (context, child) {
          if (!GetIt.I.isRegistered<MyColors>()) {
            if (MediaQuery.of(context).platformBrightness == Brightness.light) {
              GetIt.I.registerSingleton<MyColors>(MyColors.light());
            } else {
              GetIt.I.registerSingleton<MyColors>(MyColors.dark());
            }
          }

          if (!GetIt.I.isRegistered<MyTextStyles>()) {
            GetIt.I.registerSingleton<MyTextStyles>(
              MyTextStyles(GetIt.I<MyColors>().labelPrimary),
            );
          }

          return BlocProvider(
            create: (_) => GetIt.I<TasksBloc>(),
            child: child,
          );
        },
        debugShowCheckedModeBanner: false,
        supportedLocales: L10n.all,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
      );
}
