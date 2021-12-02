import 'package:emprega_unitins/constants.dart';
import 'package:flutter/material.dart';
import 'package:emprega_unitins/models/Pessoa.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:emprega_unitins/screens/detalhe_candidato/detalhe_candidato.dart';
import 'dart:async';

class Body extends StatefulWidget {
  String id_vaga;
  Body({this.id_vaga});
  @override
  BodyState createState() => BodyState();
}

class BodyState extends State<Body> {

  FutureOr naVolta(dynamic value){
    setState(() {

    });
  }

  Future<List<Pessoa>> pessoas;

  @override

  void initState() {
    super.initState();
    pessoas = getPessoasList();
  }

  Future<List<Pessoa>> getPessoasList() async {
    List<Pessoa> dados;
    var url = Uri.parse(caminho+'candidatos.php');
    var response = await http.post(url,
    body:{"id_vaga":widget.id_vaga});
    var data = json.decode(response.body);

    if (data != "Vazio") {
      dados = List<Pessoa>.from(
          data.map((model) => Pessoa.fromJson(model)));
      Fluttertoast.showToast(
        msg: "Sucesso",
        fontSize: 25,
      );
    }

    else {
      Fluttertoast.showToast(
        msg: "Sem dados",
        textColor: Colors.green,
        fontSize: 25,
      );
    }

    return dados;
  }


  void refreshPessoasList() {
    setState(() {
      pessoas = getPessoasList();
    });
  }

  Widget build(BuildContext context) {
    return FutureBuilder<List<Pessoa>>(
      initialData: [],
      future: getPessoasList(),
      builder: (context, snapshot) {
        if(snapshot.hasData) {
          return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                var data = snapshot.data[index];
                var nome=data.name;
                var telefone=data.telefone;
                var id_pessoa=data.id;
                var id_vaga=widget.id_vaga;
                switch (snapshot.connectionState) {
                  case ConnectionState.none :
                  case ConnectionState.waiting:
                    return Center(
                        child: Text("Carregando...")
                    );
                  default:
                    if (snapshot.hasError) {
                      return Center(
                        child: Text("Erro ao carregar..."),
                      );
                    } else {
                      return Center(
                        child: Card(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              ListTile(
                                title: Text("Nome: $nome"),
                                subtitle: Text("Telefone: $telefone"),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  TextButton(
                                    child: const Text('Detalhes'),
                                    onPressed: () {
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => DetalheCandidato(id_vaga: id_vaga, id_pessoa: id_pessoa))).then(naVolta);
                                    },
                                  ),
                                  const SizedBox(width: 8),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                }
              });
        }
        else{
          return Center(
            child: Text("Sem candidatos!", style: headingStyle)
          );
        }
      },
    );
  }
}