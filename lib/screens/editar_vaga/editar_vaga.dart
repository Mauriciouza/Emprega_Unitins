import 'package:flutter/material.dart';

import 'components/body.dart';

class EditarVaga extends StatelessWidget {
  static String routeName = "/editar_vaga";
  String id;
  EditarVaga({this.id});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar Vaga'),
      ),
      body: Body(id: id),
    );

  }
}
