import 'package:flutter/material.dart';

import 'components/body.dart';

class DetalheVagaAntiga extends StatelessWidget {
  static String routeName = "/detalhe_vaga_antiga";
  String id;
  DetalheVagaAntiga({this.id});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalhes da Vaga'),
      ),
      body: Body(id: id),
    );

  }
}
