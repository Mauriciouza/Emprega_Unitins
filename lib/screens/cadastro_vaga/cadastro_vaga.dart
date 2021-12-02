import 'package:flutter/material.dart';

import 'components/body.dart';

class CadastroVaga extends StatelessWidget {
  static String routeName = "/cadastro_vaga";
  String id;
  CadastroVaga({this.id});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nova Vaga'),
      ),
      body: Body(id: id),
    );

  }
}
