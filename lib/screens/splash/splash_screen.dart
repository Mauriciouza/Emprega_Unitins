import 'package:flutter/material.dart';
import 'package:emprega_unitins/screens/splash/components/body.dart';
import 'package:emprega_unitins/size_config.dart';

class SplashScreen extends StatelessWidget {
  static String routeName = "/splash";
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Body(),
    );
  }
}
