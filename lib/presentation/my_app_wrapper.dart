import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:todo/domain/models/enviroment.dart';
import 'package:todo/presentation/my_app.dart';

class MyAppWrapper extends StatelessWidget {
  const MyAppWrapper({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    String? message;
    final env = GetIt.I<Enviroment>();
    if (env == Enviroment.dev) message = "DEV";
    if (env == Enviroment.test) message = "TEST";

    if (message == null) {
      return MyApp();
    }
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Banner(
        message: message,
        location: BannerLocation.topEnd,
        child: MyApp(),
      ),
    );
  }
}
