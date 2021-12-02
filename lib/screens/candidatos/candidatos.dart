import 'package:flutter/material.dart';
import 'package:emprega_unitins/constants.dart';

import 'components/body.dart';

class Candidatos extends StatefulWidget {
  static String routeName = "/candidatos";
  String id_vaga;
  Candidatos({this.id_vaga});
  @override
  _CandidatosState createState() => _CandidatosState();
}
class _CandidatosState extends State<Candidatos> {
  @override
  String id_vaga;
  String id_pessoa;
  Widget build(BuildContext context) {
    id_vaga = widget.id_vaga;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        backgroundColor: kPrimaryColor,
        centerTitle: true,
        title: const Text(
          'Candidatos',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Body(id_vaga: id_vaga)
    );

  }
}

