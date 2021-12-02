import 'package:flutter/material.dart';

import 'components/body.dart';

class CadastroEmpresa extends StatelessWidget {
  static String routeName = "/cadastro_empresa";
  String id;
  CadastroEmpresa({this.id});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cadastrar Empresa"),
      ),
      body: Body(id: id),
    );
  }
}
