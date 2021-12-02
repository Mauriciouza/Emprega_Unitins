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

class DadosVaga extends StatefulWidget {
  String id;
  DadosVaga({this.id});

  @override
  _DadosVagaState createState() => _DadosVagaState();
}


class _DadosVagaState extends State<DadosVaga>{

  String cargo;
  String habilidades;
  String horario;
  String resumo;

  Future cadastro() async {
    var url = Uri.parse(caminho+'demitir.php');
    var id = widget.id;
    var response = await http.post(url,
        body: {
          "id": id,
        });
    var data = convert.jsonDecode(response.body);
    if (data == "0") {
      Fluttertoast.showToast(
        msg: "Demissão realizada com sucesso",
        textColor: Colors.green,
        fontSize: 25,
      );
      Navigator.pop(context);
    }
    else {
      Fluttertoast.showToast(
        msg: "Erro na demissão",
        textColor: Colors.red,
        fontSize: 25,
      );
    }
  }

  Future leitura() async{
    var url =Uri. parse(caminho+'lervagaantiga.php');
    var id=widget.id;
    var response = await http.post(url,
    body:{
      "id": id,
    });
    var data = convert.jsonDecode(response.body);
    if (data!=null){
      Fluttertoast.showToast(
        msg: "Dados carregados com sucesso",
        textColor: Colors.green,
        fontSize: 25,
      );
      return data;
    }
    else {
      Fluttertoast.showToast(
        msg: "Erro na leitura",
        textColor: Colors.red,
        fontSize: 25,
      );
      return null;
    }
  }

  Widget build(BuildContext context) {

    return FutureBuilder(
        future: leitura(),
        builder: (context, snapshot) {
          if(snapshot.hasData) {
              switch(snapshot.connectionState) {
                case ConnectionState.done :
                  return Column(
                    children:[
                      TextField(
                        readOnly: true,
                        decoration: InputDecoration(
                          labelText: "Cargo",
                          hintText: snapshot.data['cargo'],
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          suffixIcon: Icon(Icons.person),
                        ),
                      ),
                      SizedBox(height: getProportionateScreenHeight(8)),
                      TextField(
                        readOnly: true,
                        maxLines: 2,
                        decoration: InputDecoration(
                          labelText: "Habilidades",
                          hintText: snapshot.data['habilidades'],
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          suffixIcon: Icon(Icons.handyman),
                        ),
                      ),
                      SizedBox(height: getProportionateScreenHeight(8)),
                      TextField(
                        readOnly: true,
                        decoration: InputDecoration(
                          labelText: "Horário",
                          hintText: snapshot.data['horario'],
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          suffixIcon: Icon(Icons.calendar_today),
                        ),
                      ),
                      SizedBox(height: getProportionateScreenHeight(8)),
                      TextField(
                        readOnly: true,
                        maxLines: 3,
                        decoration: InputDecoration(
                          labelText: "Resumo",
                          hintText: snapshot.data['resumo'],
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          suffixIcon: Icon(Icons.mail),
                        ),
                      ),
                      SizedBox(height: getProportionateScreenHeight(8)),
                      TextField(
                        readOnly: true,
                        decoration: InputDecoration(
                          labelText: "Empregado",
                          hintText: snapshot.data['nome'],
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          suffixIcon: Icon(Icons.person),
                        ),
                      ),
                      SizedBox(height: getProportionateScreenHeight(8)),
                      TextField(
                        readOnly: true,
                        decoration: InputDecoration(
                          labelText: "Telefone",
                          hintText: snapshot.data['telefone'],
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          suffixIcon: Icon(Icons.phone),
                        ),
                      ),
                      SizedBox(height: getProportionateScreenHeight(8)),
                      DefaultButton(
                        text: "Demitir",
                        press: () {
                            cadastro();
                        },
                      ),
                    ]);

                case ConnectionState.waiting:
                  return Center(
                      child: Text("Carregando...")
                  );
                default:
                  if (snapshot.hasError) {
                    return Center(
                      child: Text("Erro ao carregar..."),
                    );
                  }
                  else{
                    return Center(child: CircularProgressIndicator());
                  }
                }
          }
          else return Center(child: CircularProgressIndicator());
        }
    );
  }
}
