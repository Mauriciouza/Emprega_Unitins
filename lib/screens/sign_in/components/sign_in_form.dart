import 'package:flutter/material.dart';
import 'package:emprega_unitins/components/form_error.dart';
import 'package:emprega_unitins/helper/keyboard.dart';
import 'package:emprega_unitins/screens/forgot_password/forgot_password_screen.dart';
import 'package:emprega_unitins/screens/home/home_screen.dart';
import 'package:emprega_unitins/screens/home_empresa/home_empresa.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:convert' as convert;

import '../../../components/default_button.dart';
import '../../../constants.dart';
import '../../../size_config.dart';

class SignForm extends StatefulWidget {
  @override
  _SignFormState createState() => _SignFormState();
}

class _SignFormState extends State<SignForm> {
  final maskFormatter = MaskTextInputFormatter(mask: '###.###.###-##', filter: { "#": RegExp(r'[0-9]') });
  final _formKey = GlobalKey<FormState>();
  String cpf;
  String senha;
  String tipo;
  String id;
  bool remember = false;
  bool isHidden = true;
  final List<String> errors = [];

  void addError({String error}) {
    if (!errors.contains(error))
      setState(() {
        errors.add(error);
      });
  }

  void removeError({String error}) {
    if (errors.contains(error))
      setState(() {
        errors.remove(error);
      });
  }

  Future login() async {
    var url = Uri.parse(caminho+'login.php');
    var response = await http.post(url,
    body: {"cpf": cpf, "senha": senha});
    var data = convert.jsonDecode(response.body);
    if(data!="Error") {
      tipo = data["tipo"];
      id = data["id"];
      var nome = data["nome"];
      if (tipo == "0") {
        Fluttertoast.showToast(
          msg: "Bem-vindo $nome",
          textColor: Colors.green,
          fontSize: 25,
        );
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => HomeScreen(id: id)));
      }
      if (tipo == "1") {
        Fluttertoast.showToast(
          msg: "Bem-vindo $nome",
          textColor: Colors.green,
          fontSize: 25,
        );
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => HomeEmpresa(id: id)));
      }
    }
    else {
      Fluttertoast.showToast(
        msg: "Usuário não encontrado ou senha incorreta",
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
          buildEmailFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildPasswordFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          Row(
            children: [
              Checkbox(
                value: remember,
                activeColor: kPrimaryColor,
                onChanged: (value) {
                  setState(() {
                    remember = value;
                  });
                },
              ),
              Text("Lembrar login"),
              Spacer(),
              GestureDetector(
                onTap: () => Navigator.pushNamed(
                    context, ForgotPasswordScreen.routeName),
                child: Text(
                  "Esqueceu a senha",
                  style: TextStyle(decoration: TextDecoration.underline, color: kPrimaryColor),
                ),
              )
            ],
          ),
          FormError(errors: errors),
          SizedBox(height: getProportionateScreenHeight(20)),
          DefaultButton(
            text: "Continue",
            press: () {
              if (_formKey.currentState.validate()) {
                _formKey.currentState.save();
                KeyboardUtil.hideKeyboard(context);
                login();
              }
            },
          ),
        ],
      ),
    );
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
      obscureText: isHidden,
      //var output = sha256.convert(utf8.encode(input)).toString()
      onSaved: (newValue) => senha = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPassNullError);
        } else if (value.length >= 8) {
          removeError(error: kShortPassError);
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kPassNullError);
          return "";
        } else if (value.length < 8) {
          addError(error: kShortPassError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Senha",
        hintText: "Informe sua senha",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: IconButton(
          icon: Icon(isHidden ? Icons.visibility_off : Icons.visibility),
          onPressed:(){
            toogle();
          },
        ),
      ),
    );
  }

  TextFormField buildEmailFormField() {
    return TextFormField(
      inputFormatters: [maskFormatter],
      keyboardType: TextInputType.number,
      onSaved: (newValue) => cpf = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kCPFNullError);
        } else if (cpfValidator.hasMatch(value)) {
          removeError(error: kInvalidCPFError);
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kCPFNullError);
          return "";
        } else if (!cpfValidator.hasMatch(value)) {
          addError(error: kInvalidCPFError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "CPF",
        hintText: "Informe seu CPF",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Icon(Icons.person),
      ),
    );
  }
  void toogle(){
    isHidden = !isHidden;
    setState(() {});
  }
}
