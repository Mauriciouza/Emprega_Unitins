import 'dart:async';
import 'package:flutter/material.dart';

import 'components/body.dart';
import '../../constants.dart';
import 'components/hab_add_cad.dart';

class CompleteHabAddScreen extends StatefulWidget {
  static String routeName = "/complete_profile_hab_add";
  String id;
  CompleteHabAddScreen({this.id});
  @override
  _CompleteHabAddScreenState createState() => _CompleteHabAddScreenState();
}

class _CompleteHabAddScreenState extends State<CompleteHabAddScreen>{

  FutureOr naVolta(dynamic value){
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Habilidades Adicionais'),
      ),
      body: Body(id: widget.id),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => HabAddCad(id: widget.id))).then(naVolta);
        },
        label: const Text('Cadastrar'),
        icon: const Icon(Icons.add_circle_outline),
        backgroundColor: kPrimaryColor,
      ),
    );
  }
}
