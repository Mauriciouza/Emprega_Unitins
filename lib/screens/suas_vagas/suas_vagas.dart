import 'package:flutter/material.dart';
import 'package:emprega_unitins/constants.dart';

import 'components/body.dart';

class SuasVagas extends StatefulWidget {
  static String routeName = "/suas_vagas";
  String id;
  SuasVagas({this.id});
  @override
  _SuasVagasState createState() => _SuasVagasState();
}
class _SuasVagasState extends State<SuasVagas> {
  @override
  String id;
  Widget build(BuildContext context) {
    id = widget.id;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        backgroundColor: kPrimaryColor,
        centerTitle: true,
        title: const Text(
          'Suas vagas',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Body(id: id)
    );


  }
}

