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

class DadosCandidato extends StatefulWidget {
  String id_vaga;
  String id_pessoa;
  DadosCandidato({this.id_vaga, this.id_pessoa});

  @override
  _DadosCandidatoState createState() => _DadosCandidatoState();
}


class _DadosCandidatoState extends State<DadosCandidato>{

  String nome;
  String email;
  String cpf;
  String telefone;
  String dt_nasc;
  String sexo;

  Future contratar() async {
    var url = Uri.parse(caminho+'contratar.php');
    var id_vaga = widget.id_vaga;
    var id_pessoa = widget.id_pessoa;
    var response = await http.post(url,
        body: {
          "id_vaga": id_vaga,
          "id_pessoa": id_pessoa
        });
    var data = convert.jsonDecode(response.body);
    if (data == "0") {
      Fluttertoast.showToast(
        msg: "Contratação realizada com sucesso",
        textColor: Colors.green,
        fontSize: 25,
      );
      Navigator.pop(context);
    }
    else {
      Fluttertoast.showToast(
        msg: "Erro na contratação",
        textColor: Colors.red,
        fontSize: 25,
      );
    }
  }

  Future leitura() async{
    var url =Uri. parse(caminho+'lerdados.php');
    var id_pessoa=widget.id_pessoa;
    var response = await http.post(url,
    body:{
      "id": id_pessoa,
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
            if(snapshot.data['sexo']=="0")sexo='Masculino';
            else sexo='Feminino';
            //return Column(
              switch(snapshot.connectionState) {
                case ConnectionState.done :
                  return Column(
                    children:[
                      TextField(
                        readOnly: true,
                        decoration: InputDecoration(
                          labelText: "Nome",
                          hintText: snapshot.data['nome'],
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          suffixIcon: Icon(Icons.person),
                        ),
                      ),
                      SizedBox(height: getProportionateScreenHeight(8)),
                      TextField(
                        readOnly: true,
                        decoration: InputDecoration(
                          labelText: "Email",
                          hintText: snapshot.data['email'],
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          suffixIcon: Icon(Icons.mail),
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
                      TextField(
                        readOnly: true,
                        decoration: InputDecoration(
                          labelText: "CPF",
                          hintText: snapshot.data['cpf'],
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          suffixIcon: Icon(Icons.description_outlined),
                        ),
                      ),
                      SizedBox(height: getProportionateScreenHeight(8)),
                      TextField(
                        readOnly: true,
                        decoration: InputDecoration(
                          labelText: "Data de Nascimento",
                          hintText: snapshot.data['dt_nasc'],
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          suffixIcon: Icon(Icons.calendar_today),
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
                      TextField(
                        readOnly: true,
                        decoration: InputDecoration(
                          labelText: "Sexo",
                          hintText: sexo,
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          suffixIcon: Icon(Icons.transgender),
                        ),
                      ),
                      SizedBox(height: getProportionateScreenHeight(8)),
                      DefaultButton(
                        text: "Contratar",
                        press: () {
                            contratar();
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
