import 'package:flutter/material.dart';
import 'package:emprega_unitins/constants.dart';
import 'package:emprega_unitins/size_config.dart';

import 'dados_vaga.dart';

class Body extends StatelessWidget {
  String id;
  Body({this.id});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text("Detalhes da vaga", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black)),
                SizedBox(height: SizeConfig.screenHeight * 0.01),
                DadosVaga(id: id),
                SizedBox(height: getProportionateScreenHeight(20)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
