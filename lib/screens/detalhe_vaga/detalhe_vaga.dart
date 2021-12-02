import 'package:flutter/material.dart';

import 'components/body.dart';

class DetalheVaga extends StatelessWidget {
  static String routeName = "/detalhe_vaga";
  String id_vaga;
  String id_pessoa;
  DetalheVaga({this.id_vaga, this.id_pessoa});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalhes da Vaga'),
      ),
      body: Body(id_vaga: id_vaga, id_pessoa: id_pessoa),
    );

  }
}
