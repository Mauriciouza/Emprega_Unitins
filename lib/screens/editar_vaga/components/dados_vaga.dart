import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:emprega_unitins/components/default_button.dart';
import 'package:emprega_unitins/components/form_error.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import '../../../constants.dart';
import '../../../size_config.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:convert' as convert;
import 'package:emprega_unitins/models/Vaga.dart';

class DadosVaga extends StatefulWidget {
  String id;
  DadosVaga({this.id});

  @override
  _DadosVagaState createState() => _DadosVagaState();
}


class _DadosVagaState extends State<DadosVaga>{
  final _formKey = GlobalKey<FormState>();

  String cargo;
  String habilidades;
  String horario;
  String resumo;

  final List<String> errors = [];
  Future<Vaga> vaga;

  void initState(){
    super.initState();
    vaga=leitura(widget.id);
  }

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
    var url = Uri.parse(caminho+'editarvaga.php');
    var response = await http.post(url,
        body: {
          "id": widget.id,
          "cargo": cargo,
          "habilidades": habilidades,
          "horario": horario,
          "resumo": resumo,
        });
    var data = convert.jsonDecode(response.body);
    if (data == "0") {
      Fluttertoast.showToast(
        msg: "Vaga atualizada com sucesso",
        textColor: Colors.green,
        fontSize: 25,
      );
    }
    else {
      Fluttertoast.showToast(
        msg: "Erro no cadastro",
        textColor: Colors.red,
        fontSize: 25,
      );
    }
  }

  Future<Vaga> leitura(String id) async {

    var url = Uri.parse(caminho+'dadosvaga.php');
    var response = await http.post(url,
        body: {
          "id": id,
        });
    var data = convert.jsonDecode(response.body);
    if (data!="Vazio") {
      Fluttertoast.showToast(
        msg: "Informações carregadas com sucesso",
        textColor: Colors.green,
        fontSize: 25,
      );
      Vaga dados = Vaga.fromJson(data);
      return dados;
    }
    else {
      Fluttertoast.showToast(
        msg: "Erro na leitura",
        textColor: Colors.red,
        fontSize: 25,
      );
    }

  }

  void Inicializar(Vaga vaga) {
    cargo=vaga.cargo;
    habilidades=vaga.habilidades;
    horario=vaga.horario;
    resumo=vaga.resumo;
  }

  Widget build(BuildContext context) {
    return FutureBuilder<Vaga>(
      future: leitura(widget.id),
      builder: (context, snapshot){
        if(snapshot.hasData) {
          Inicializar(snapshot.data);
          return Form(
            key: _formKey,
            child: Column(
              children: [
                buildCargoFormField(),
                SizedBox(height: getProportionateScreenHeight(8)),
                buildHabilidadesFormField(),
                SizedBox(height: getProportionateScreenHeight(8)),
                buildHorarioFormField(),
                SizedBox(height: getProportionateScreenHeight(8)),
                buildResumoFormField(),
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
        else{
          return Center(child: CircularProgressIndicator());
        }
      }
    );
  }

  TextFormField buildResumoFormField() {
    return TextFormField(
      initialValue: resumo,
      maxLines: 3,
      keyboardType: TextInputType.emailAddress,
      onSaved: (newValue) => resumo = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kResumoNullError);
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kResumoNullError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Resumo",
        hintText: "Informe o resumo",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Icon(Icons.mail),
      ),
    );
  }

  TextFormField buildHorarioFormField() {
    return TextFormField(
      initialValue: horario,
      keyboardType: TextInputType.emailAddress,
      onSaved: (newValue) => horario = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kHorarioNullError);
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kHorarioNullError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Horário",
        hintText: "Informe o horário",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Icon(Icons.calendar_today),
      ),
    );
  }

  TextFormField buildHabilidadesFormField() {
    return TextFormField(
      initialValue: habilidades,
      maxLines: 2,
      keyboardType: TextInputType.emailAddress,
      onSaved: (newValue) => habilidades = newValue,
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
        labelText: "Habilidades",
        hintText: "Informe as habilidades",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Icon(Icons.handyman),
      ),
    );
  }

  TextFormField buildCargoFormField() {
    return TextFormField(
      initialValue: cargo,
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
        hintText: "Informe o cargo",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Icon(Icons.person),
      ),
    );
  }
}
