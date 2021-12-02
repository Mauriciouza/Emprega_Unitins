import 'package:flutter/material.dart';

import 'components/body.dart';

class CompleteEndereco extends StatelessWidget {
  static String routeName = "/complete_endereco";
  String id;
  CompleteEndereco({this.id});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Endereço'),
      ),
      body: Body(id: id),
    );

  }
}
