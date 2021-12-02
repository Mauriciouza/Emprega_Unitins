import 'package:flutter/material.dart';
import 'package:emprega_unitins/routes.dart';
import 'package:emprega_unitins/screens/profile/profile_screen.dart';
import 'package:emprega_unitins/screens/splash/splash_screen.dart';
import 'package:emprega_unitins/theme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Emprega Unitins',
      theme: theme(),
      initialRoute: SplashScreen.routeName,
      routes: routes,
    );
  }
}
