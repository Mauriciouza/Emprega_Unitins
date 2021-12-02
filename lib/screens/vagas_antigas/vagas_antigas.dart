import 'package:flutter/material.dart';
import 'package:emprega_unitins/constants.dart';
import 'dart:async';
import 'components/body.dart';

class VagasAntigas extends StatefulWidget {
  static String routeName = "/vagas_antigas";
  String id;
  VagasAntigas({this.id});
  @override
  _VagasAntigasState createState() => _VagasAntigasState();
}
class _VagasAntigasState extends State<VagasAntigas> {

  FutureOr naVolta(dynamic value){
    setState(() {

    });
  }

  String id;
  Widget build(BuildContext context) {
    id=widget.id;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        backgroundColor: kPrimaryColor,
        centerTitle: true,
        title: const Text(
          'Vagas Preenchidas',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Body(id: id),
    );
  }
}

