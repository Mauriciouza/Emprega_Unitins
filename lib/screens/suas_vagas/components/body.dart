import 'package:emprega_unitins/constants.dart';
import 'package:flutter/material.dart';
import 'package:emprega_unitins/models/Vaga.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../size_config.dart';

class Body extends StatefulWidget {
  String id;
  Body({this.id});
  @override
  BodyState createState() => BodyState();
}

class BodyState extends State<Body> {

  Future<List<Vaga>> vagas;

  @override

  void initState() {
    super.initState();
    vagas = getVagasList();
  }

  Future<List<Vaga>> getVagasList() async {
    List<Vaga> dados;
    var url = Uri.parse(caminho+'suasvagas.php');
    var response = await http.post(url,
    body:{"id":widget.id});
    var data = json.decode(response.body);

    if (data != "Vazio") {
      dados = List<Vaga>.from(
          data.map((model) => Vaga.fromJson(model)));
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

  Future<List<Vaga>> remover(String id, String id_pessoa) async {
    List<Vaga> dados;
    var url = Uri.parse(caminho+'remover.php');
    var response = await http.post(url,
        body:{"id_vaga": id, "id_pessoa": id_pessoa});
    var data = json.decode(response.body);

    if (data == "0") {
      Fluttertoast.showToast(
        msg: "Sucesso",
        fontSize: 25,
      );
      setState(() {

      });
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

  void refreshVagasList() {
    setState(() {
      vagas = getVagasList();
    });
  }

  Widget build(BuildContext context) {
    return FutureBuilder<List<Vaga>>(
      initialData: [],
      future: getVagasList(),
      builder: (context, snapshot) {
        if(snapshot.hasData) {
          return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                var data = snapshot.data[index];
                var cargo=data.cargo;
                var resumo=data.resumo;
                var id=data.id;
                var id_pessoa=widget.id;
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
                                title: Text("Cargo: $cargo"),
                                subtitle: Text("Resumo: $resumo"),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  TextButton(
                                    child: const Text('Remover Candidatura'),
                                    onPressed: () {
                                      remover(id, id_pessoa);
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
            child: Text("Sem vagas!", style: headingStyle)
          );
        }
      },
    );
  }
}