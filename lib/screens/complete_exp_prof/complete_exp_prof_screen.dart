import 'dart:async';
import 'package:flutter/material.dart';

import 'components/body.dart';
import '../../constants.dart';
import 'components/exp_prof_cad.dart';

class CompleteExpProfScreen extends StatefulWidget {
  static String routeName = "/complete_profile_exp_prof";
  String id;
  CompleteExpProfScreen({this.id});
  @override
  _CompleteExpProfScreenState createState() => _CompleteExpProfScreenState();
}

class _CompleteExpProfScreenState extends State<CompleteExpProfScreen>{

  FutureOr naVolta(dynamic value){
    setState(() {

    });
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Experiência Profissional'),
      ),
      body: Body(id: widget.id),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => ExpProfCad(id: widget.id))).then(naVolta);
        },
        label: const Text('Cadastrar'),
        icon: const Icon(Icons.add_circle_outline),
        backgroundColor: kPrimaryColor,
      ),
    );
  }
}
