import 'package:flutter/material.dart';
import 'package:emprega_unitins/constants.dart';
import 'package:emprega_unitins/size_config.dart';

import 'dados_candidato.dart';

class Body extends StatelessWidget {
  String id_vaga;
  String id_pessoa;
  Body({this.id_vaga, this.id_pessoa});
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
                //SizedBox(height: SizeConfig.screenHeight * 0.01),
                Text("Detalhes do Candidato", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black)),
                SizedBox(height: SizeConfig.screenHeight * 0.01),
                DadosCandidato(id_vaga: id_vaga, id_pessoa: id_pessoa),
                SizedBox(height: getProportionateScreenHeight(20)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
