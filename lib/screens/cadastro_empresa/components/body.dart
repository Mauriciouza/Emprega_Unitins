import 'package:flutter/material.dart';
import 'package:emprega_unitins/constants.dart';
import 'package:emprega_unitins/size_config.dart';

import 'cad_emp_form.dart';

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
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(10)),
          child: SingleChildScrollView(
            child: Column(
              children: [
                //SizedBox(height: SizeConfig.screenHeight * 0.04), // 4%
                Text("Cadastrar empresa", style: headingStyle),
                Text(
                  "Agora informe os dados da empresa para continuar",
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: SizeConfig.screenHeight * 0.02),
                CadEmpForm(id: id),
                SizedBox(height: getProportionateScreenHeight(10)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
