import 'package:flutter/material.dart';
import 'package:emprega_unitins/constants.dart';
import 'package:emprega_unitins/size_config.dart';

import 'dados_empresa.dart';

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
                SizedBox(height: SizeConfig.screenHeight * 0.01),
                Text("Complete as informações", style: headingStyle, textAlign: TextAlign.center),
                Text(
                  "Preencha com os dados básicos da empresa",
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: SizeConfig.screenHeight * 0.03),
                DadosEmpresa(id: id),
                SizedBox(height: getProportionateScreenHeight(30)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
