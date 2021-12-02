import 'package:flutter/material.dart';
import 'package:emprega_unitins/constants.dart';
import 'package:emprega_unitins/size_config.dart';

import 'sign_up_form.dart';

class Body extends StatelessWidget {
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
                Text("Cadastrar conta", style: headingStyle),
                Text(
                  "Informe seus dados para continuar",
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: SizeConfig.screenHeight * 0.02),
                SignUpForm(),
                SizedBox(height: getProportionateScreenHeight(10)),
                Text(
                  'Clicando em continuar você estará concordando com \nnossos Termos e Condições',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.caption,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
