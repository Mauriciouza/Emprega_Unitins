import 'package:flutter/material.dart';

import 'components/body.dart';

class DetalheCandidato extends StatelessWidget {
  static String routeName = "/detalhe_candidato";
  String id_vaga;
  String id_pessoa;
  DetalheCandidato({this.id_vaga, this.id_pessoa});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalhes do Candidato'),
      ),
      body: Body(id_vaga: id_vaga, id_pessoa: id_pessoa),
    );

  }
}
