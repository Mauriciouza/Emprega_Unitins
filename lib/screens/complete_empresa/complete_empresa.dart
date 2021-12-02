import 'package:flutter/material.dart';

import 'components/body.dart';

class CompleteEmpresa extends StatelessWidget {
  static String routeName = "/complete_empresa";
  String id;
  CompleteEmpresa({this.id});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dados Básicos'),
      ),
      body: Body(id: id),
    );

  }
}
