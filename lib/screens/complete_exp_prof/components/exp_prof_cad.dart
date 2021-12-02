import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:emprega_unitins/components/default_button.dart';
import 'package:emprega_unitins/components/form_error.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import '../../../constants.dart';
import '../../../size_config.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:convert';

class ExpProfCad extends StatefulWidget {
  static String routeName = "/complete_profile_exp_prof_cad";
  String id;
  ExpProfCad({this.id});

  @override
  _ExpProfCadState createState() => _ExpProfCadState();
}

class _ExpProfCadState extends State<ExpProfCad>{

  final maskFormatterDt = MaskTextInputFormatter(mask: '##/##/####', filter: { "#": RegExp(r'[0-9]') });
  final _formKey = GlobalKey<FormState>();
  String empresa;
  String cargo;
  String dt_inicio;
  String dt_fim;

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
    var url = Uri.parse(caminho+'expprof.php');
    var response = await http.post(url,
        body: {
          "id": widget.id,
          "empresa": empresa,
          "cargo": cargo,
          "dt_inicio": dt_inicio,
          "dt_fim": dt_fim,
        });
    var data = jsonDecode(response.body);
    if (data == "0") {
      Fluttertoast.showToast(
        msg: "Experiencia adicionada com sucesso",
        textColor: Colors.green,
        fontSize: 25,
      );
      Navigator.pop(context);
    }
    else {
      Fluttertoast.showToast(
        msg: "Erro na operação",
        textColor: Colors.red,
        fontSize: 25,
      );
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Experiência Profissional'),
      ),
      body: SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: SizeConfig.screenHeight * 0.01),
                Text("Complete seu perfil", style: headingStyle),
                Text(
                  "Preencha com suas experiências profissionais",
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: SizeConfig.screenHeight * 0.03),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      buildEmpresaFormField(),
                      SizedBox(height: getProportionateScreenHeight(8)),
                      buildCargoFormField(),
                      SizedBox(height: getProportionateScreenHeight(8)),
                      buildDtIniFormField(),
                      SizedBox(height: getProportionateScreenHeight(8)),
                      buildDtFimFormField(),
                      SizedBox(height: getProportionateScreenHeight(8)),

                      FormError(errors: errors),
                      SizedBox(height: getProportionateScreenHeight(20)),
                      DefaultButton(
                        text: "Cadastrar",
                        press: () {
                          if (_formKey.currentState.validate()) {
                            _formKey.currentState.save();
                            cadastro();
                          }
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: getProportionateScreenHeight(30)),
              ],
            ),
          ),
        ),
      ),
      ),
    );
  }

  TextFormField buildDtFimFormField() {
    return TextFormField(
      inputFormatters: [maskFormatterDt],
      keyboardType: TextInputType.number,
      onSaved: (newValue) => dt_fim = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kDtFimNullError);
        } else if (dtValidator.hasMatch(value)) {
          removeError(error: kInvalidDtFimError);
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kDtFimNullError);
          return "";
        } else if (!dtValidator.hasMatch(value)) {
          addError(error: kInvalidDtFimError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Data Final",
        hintText: "Informe a data final",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Icon(Icons.calendar_today),
      ),
    );
  }

  TextFormField buildDtIniFormField() {
    return TextFormField(
      inputFormatters: [maskFormatterDt],
      keyboardType: TextInputType.number,
      onSaved: (newValue) => dt_inicio = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kDtIniNullError);
        } else if (dtValidator.hasMatch(value)) {
          removeError(error: kInvalidDtIniError);
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kDtIniNullError);
          return "";
        } else if (!dtValidator.hasMatch(value)) {
          addError(error: kInvalidDtIniError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Data de Início",
        hintText: "Informe a data de início",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Icon(Icons.calendar_today),
      ),
    );
  }

  TextFormField buildCargoFormField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      onSaved: (newValue) => cargo = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kCargoNullError);
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kCargoNullError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Cargo",
        hintText: "Informe seu cargo",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Icon(Icons.person),
      ),
    );
  }

  TextFormField buildEmpresaFormField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      onSaved: (newValue) => empresa = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kEmpresaNullError);
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kEmpresaNullError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Empresa",
        hintText: "Informe a empresa",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Icon(Icons.account_balance_outlined),
      ),
    );
  }
}
