import 'package:flutter/material.dart';
import 'package:emprega_unitins/components/default_button.dart';
import 'package:emprega_unitins/components/form_error.dart';
import 'package:emprega_unitins/components/no_account_text.dart';
import 'package:emprega_unitins/screens/sign_in/sign_in_screen.dart';
import 'package:emprega_unitins/size_config.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:convert';

import '../../../constants.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: SingleChildScrollView(
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: Column(
            children: [
              SizedBox(height: SizeConfig.screenHeight * 0.04),
              Text(
                "Esqueceu a senha",
                style: TextStyle(
                  fontSize: getProportionateScreenWidth(28),
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "Por favor entre com seu CPF e um email será enviado para recuperar sua senha",
                textAlign: TextAlign.center,
              ),
              SizedBox(height: SizeConfig.screenHeight * 0.1),
              ForgotPassForm(),
            ],
          ),
        ),
      ),
    );
  }
}

class ForgotPassForm extends StatefulWidget {
  @override
  _ForgotPassFormState createState() => _ForgotPassFormState();
}

class _ForgotPassFormState extends State<ForgotPassForm> {
  final maskFormatter = MaskTextInputFormatter(mask: '###.###.###-##', filter: { "#": RegExp(r'[0-9]') });
  final _formKey = GlobalKey<FormState>();
  List<String> errors = [];
  String cpf;

  Future resetar() async {
    var url = Uri.parse(caminho+'esqueceu.php');
    var response = await http.post(url,
        body: {"cpf": cpf});
    var data = jsonDecode(response.body);
    if (data == "0") {
      Fluttertoast.showToast(
        msg: "Aguarde alguns instantes e um email será enviado com sua nova senha.",
        textColor: Colors.green,
        timeInSecForIosWeb: 3,
        fontSize: 25,
      );
      Navigator.pushNamed(context, SignInScreen.routeName);
    }
    else if(data=="1"){
      Fluttertoast.showToast(
        msg: "Não foi possível resetar sua senha.",
        textColor: Colors.yellow,
        timeInSecForIosWeb: 3,
        fontSize: 25,
      );
    }
    else {
      Fluttertoast.showToast(
        msg: "Usuário não encontrado.",
        textColor: Colors.red,
        fontSize: 25,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            inputFormatters: [maskFormatter],
            keyboardType: TextInputType.number,
            onSaved: (newValue) => cpf = newValue,
            onChanged: (value) {
              if (value.isNotEmpty && errors.contains(kCPFNullError)) {
                setState(() {
                  errors.remove(kCPFNullError);
                });
              } else if (cpfValidator.hasMatch(value) &&
                  errors.contains(kInvalidCPFError)) {
                setState(() {
                  errors.remove(kInvalidCPFError);
                });
              }
              return null;
            },
            validator: (value) {
              if (value.isEmpty && !errors.contains(kCPFNullError)) {
                setState(() {
                  errors.add(kCPFNullError);
                });
              } else if (!cpfValidator.hasMatch(value) &&
                  !errors.contains(kInvalidCPFError)) {
                setState(() {
                  errors.add(kInvalidCPFError);
                });
              }
              return null;
            },
            decoration: InputDecoration(
              labelText: "CPF",
              hintText: "Entre com seu CPF",
              floatingLabelBehavior: FloatingLabelBehavior.always,
              suffixIcon: Icon(Icons.person),
            ),
          ),
          SizedBox(height: getProportionateScreenHeight(30)),
          FormError(errors: errors),
          SizedBox(height: SizeConfig.screenHeight * 0.1),
          DefaultButton(
            text: "Continue",
            press: () {
              if (_formKey.currentState.validate()) {
                _formKey.currentState.save();
                resetar();
              }
            },
          ),
          SizedBox(height: SizeConfig.screenHeight * 0.1),
          NoAccountText(),
        ],
      ),
    );
  }
}
