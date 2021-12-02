import 'dart:async';
import 'package:flutter/material.dart';

import 'components/body.dart';
import '../../constants.dart';
import 'components/form_acad_cad.dart';

class CompleteFormAcadScreen extends StatefulWidget {
  static String routeName = "/complete_profile_form_acad";
  String id;
  CompleteFormAcadScreen({this.id});
  @override
  _CompleteFormAcadScreenState createState() => _CompleteFormAcadScreenState();
}

class _CompleteFormAcadScreenState extends State<CompleteFormAcadScreen>{

  FutureOr naVolta(dynamic value){
    setState(() {

    });
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Formação Acadêmica'),
      ),
      body: Body(id: widget.id),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => FormAcadCad(id: widget.id))).then(naVolta);
        },
        label: const Text('Cadastrar'),
        icon: const Icon(Icons.add_circle_outline),
        backgroundColor: kPrimaryColor,
      ),
    );
  }
}
