import 'package:flutter/material.dart';

import 'components/body.dart';

class ProfileEmpresa extends StatelessWidget {
  static String routeName = "/profile_empresa";
  String id;
  ProfileEmpresa({this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Perfil"),
      ),
      body: Body(id: id),
    );
  }
}
