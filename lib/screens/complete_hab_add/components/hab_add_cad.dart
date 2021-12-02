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

class HabAddCad extends StatefulWidget {
  static String routeName = "/complete_profile_hab_add_cad";
  String id;
  HabAddCad({this.id});

  @override
  _HabAddCadState createState() => _HabAddCadState();
}

class _HabAddCadState extends State<HabAddCad>{

  final maskFormatterDtNasc = MaskTextInputFormatter(mask: '##/##/####', filter: { "#": RegExp(r'[0-9]') });
  final _formKey = GlobalKey<FormState>();
  String habilidade;
  String nivel;

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
    var url = Uri.parse(caminho+'habadd.php');
    var response = await http.post(url,
        body: {
          "id": widget.id,
          "habilidade": habilidade,
          "nivel": nivel,
        });
    var data = jsonDecode(response.body);
    if (data == "0") {
      Fluttertoast.showToast(
        msg: "Habilidade adicionada com sucesso",
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
        title: Text('Habilidades Adicionais'),
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
                  "Preencha com suas habilidades adicionais",
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: SizeConfig.screenHeight * 0.03),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      buildHabilidadeFormField(),
                      SizedBox(height: getProportionateScreenHeight(8)),
                      buildNivelFormField(),
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

  TextFormField buildNivelFormField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      onSaved: (newValue) => nivel = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kNivelNullError);
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kNivelNullError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Nível",
        hintText: "Básico/Médio/Avançado",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Icon(Icons.star),
      ),
    );
  }

  TextFormField buildHabilidadeFormField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      onSaved: (newValue) => habilidade = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kHabNullError);
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kHabNullError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Habilidade",
        hintText: "Informe a habilidade",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Icon(Icons.handyman),
      ),
    );
  }
}
