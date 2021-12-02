import 'package:flutter/material.dart';
import 'package:emprega_unitins/constants.dart';
import 'package:emprega_unitins/size_config.dart';

import 'dados_endereco.dart';

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
                Text("Complete o endereço", style: headingStyle),
                Text(
                  "Preencha como os dados de endereço",
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: SizeConfig.screenHeight * 0.03),
                DadosEndereco(id: id),
                SizedBox(height: getProportionateScreenHeight(30)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
