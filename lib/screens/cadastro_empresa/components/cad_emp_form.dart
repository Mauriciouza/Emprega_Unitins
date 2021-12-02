import 'package:flutter/material.dart';
import 'package:emprega_unitins/components/default_button.dart';
import 'package:emprega_unitins/components/form_error.dart';

import 'package:emprega_unitins/screens/home/home_screen.dart';
import 'package:emprega_unitins/screens/home_empresa/home_empresa.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:convert' as convert;

import '../../../constants.dart';
import '../../../size_config.dart';


class CadEmpForm extends StatefulWidget {
  String id;
  CadEmpForm({this.id});
  @override
  _CadEmpFormState createState() => _CadEmpFormState();
}

class _CadEmpFormState extends State<CadEmpForm> {
  final maskFormatterCNPJ = MaskTextInputFormatter(mask: '##.###.###/####-##', filter: { "#": RegExp(r'[0-9]') });
  final maskFormatterphone = MaskTextInputFormatter(mask: '(##)#####-####', filter: { "#": RegExp(r'[0-9]') });
  final _formKey = GlobalKey<FormState>();

  String id;
  String nome_fantasia;
  String cnpj;
  String razao_social;
  String telefone;
  String email;

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

  Future cadastro() async {
    var url = Uri.parse(caminho+'cademp.php');
    var response = await http.post(url,
        body: {
          "id": widget.id,
          "nome_fantasia": nome_fantasia,
          "cnpj": cnpj,
          "razao_social": razao_social,
          "telefone": telefone,
          "email": email,
        });
    var data = convert.jsonDecode(response.body);
    if (data == "Sucesso") {
      Fluttertoast.showToast(
        msg: "Cadastro feito com sucesso",
        textColor: Colors.green,
        fontSize: 25,
      );
      Navigator.push(context, MaterialPageRoute(builder: (context) => HomeEmpresa(id: widget.id)));
    }
    else {
      Fluttertoast.showToast(
        msg: "Erro no cadastro",
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
          buildNomeFantasiaFormField(),
          SizedBox(height: getProportionateScreenHeight(8)),
          buildCNPJFormField(),
          SizedBox(height: getProportionateScreenHeight(8)),
          buildRazaoSocialFormField(),
          SizedBox(height: getProportionateScreenHeight(8)),
          buildTelefoneFormField(),
          SizedBox(height: getProportionateScreenHeight(8)),
          buildEmailFormField(),
          SizedBox(height: getProportionateScreenHeight(8)),

          FormError(errors: errors),
          SizedBox(height: getProportionateScreenHeight(20)),
          DefaultButton(
            text: "Continue",
            press: () {
              if (_formKey.currentState.validate()) {
                _formKey.currentState.save();
                cadastro();
              }
            },
          ),
        ],
      ),
    );
  }
  TextFormField buildEmailFormField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      onSaved: (newValue) => email = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kEmailNullError);
        } else if (emailValidatorRegExp.hasMatch(value)) {
          removeError(error: kInvalidEmailError);
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kEmailNullError);
          return "";
        } else if (!emailValidatorRegExp.hasMatch(value)) {
          addError(error: kInvalidEmailError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Email",
        hintText: "Informe e email da empresa",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Icon(Icons.mail),
      ),
    );
  }

  TextFormField buildTelefoneFormField() {
    return TextFormField(
      inputFormatters: [maskFormatterphone],
      keyboardType: TextInputType.number,
      onSaved: (newValue) => telefone = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPhoneNumberNullError);
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kPhoneNumberNullError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Telefone",
        hintText: "Informe o telefone da empresa",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Icon(Icons.phone),
      ),
    );
  }

  TextFormField buildRazaoSocialFormField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      onSaved: (newValue) => razao_social = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kRazaoSocialNullError);
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kRazaoSocialNullError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Razão Social",
        hintText: "Informe a razão social",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Icon(Icons.account_balance_outlined),
      ),
    );
  }

  TextFormField buildCNPJFormField() {
    return TextFormField(
      inputFormatters: [maskFormatterCNPJ],
      keyboardType: TextInputType.number,
      onSaved: (newValue) => cnpj = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kCNPJNullError);
        } else if (cnpjValidator.hasMatch(value)) {
          removeError(error: kInvalidCNPJError);
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kCNPJNullError);
          return "";
        } else if (!cnpjValidator.hasMatch(value)) {
          addError(error: kInvalidCNPJError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
          labelText: "CNPJ",
          hintText: "Informe o CNPJ",
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: Icon(Icons.description_outlined)
      ),
    );
  }

  TextFormField buildNomeFantasiaFormField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      onSaved: (newValue) => nome_fantasia = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kNomeFantasiaNullError);
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kNomeFantasiaNullError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Nome Fantasia",
        hintText: "Informe o nome fantasia",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Icon(Icons.person),
      ),
    );
  }
}
