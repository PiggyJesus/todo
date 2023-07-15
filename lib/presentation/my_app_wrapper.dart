import 'package:flutter/material.dart';
import 'package:todo/presentation/my_app.dart';

class MyAppWrapper extends StatelessWidget {
  final String? message;
  const MyAppWrapper({
    this.message,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    if (message == null) {
      return MyApp();
    }
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Banner(
        message: message!,
        location: BannerLocation.topEnd,
        child: MyApp(),
      ),
    );
  }
}
