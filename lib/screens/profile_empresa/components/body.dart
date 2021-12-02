import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:emprega_unitins/screens/complete_empresa/complete_empresa.dart';
import 'package:emprega_unitins/screens/complete_endereco/complete_endereco.dart';

import 'profile_menu.dart';

class Body extends StatelessWidget {
  String id;
  Body({this.id});
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          SizedBox(height: 20),
          ProfileMenu(
            text: "Dados básicos",
            icon: "assets/icons/User Icon.svg",
            press: () => Navigator.push(context, MaterialPageRoute(builder: (context) => CompleteEmpresa(id: id))),
          ),
          ProfileMenu(
            text: "Endereço",
            icon: "assets/icons/Bell.svg",
            press: () => Navigator.push(context, MaterialPageRoute(builder: (context) => CompleteEndereco(id: id))),
          ),
        ],
      ),
    );
  }
}
