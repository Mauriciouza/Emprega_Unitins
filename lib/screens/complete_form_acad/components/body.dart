import 'package:flutter/material.dart';
import 'package:emprega_unitins/constants.dart';
import 'package:emprega_unitins/size_config.dart';
import 'package:emprega_unitins/models/Forms.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class Body extends StatefulWidget {
  String id;
  Body({this.id});
  @override
  BodyState createState() => BodyState();
}

class BodyState extends State<Body> {
  Future<List<Forms>> forms;

  void initState() {
    super.initState();
    forms = getFormsList();
  }

  Future<List<Forms>> getFormsList() async {
    List<Forms> dados;
    var url = Uri.parse(caminho+'forms.php');
    var response = await http.post(url,body:{"id": widget.id,});
    var data = json.decode(response.body);
    if (data != "Vazio") {
      dados = List<Forms>.from(
          data.map((model) => Forms.fromJson(model)));
      Fluttertoast.showToast(
        msg: "Sucesso",
        fontSize: 25,
      );
    }

    else{
      Fluttertoast.showToast(
        msg: "Sem dados",
        textColor: Colors.green,
        fontSize: 25,
      );
    }

    return dados;
  }

  void refreshFormsList() {
    setState(() {
      forms = getFormsList();
    });
  }


  Widget build(BuildContext context) {
                return FutureBuilder<List<Forms>>(
                  initialData: [],
                  future: getFormsList(),
                  builder: (context, snapshot) {
                    if(snapshot.hasData) {
                      return ListView.builder(
                          itemCount: snapshot.data.length,
                          itemBuilder: (BuildContext context, int index) {
                            var data = snapshot.data[index];
                            var curso = data.curso;
                            var instituicao = data.instituicao;
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
                                            title: Text("Curso: $curso"),
                                            subtitle: Text("Instituição: $instituicao"),
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: <Widget>[
                                              TextButton(
                                                child: const Text('Detalhes'),
                                                onPressed: () {},
                                              ),
                                              const SizedBox(width: 8),
                                              TextButton(
                                                child: const Text('Remover'),
                                                onPressed: () {},
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
                          }
                      );
                    }
                    else{
                      return SafeArea(
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
                                      "Adicione uma formação acadêmica",
                                      textAlign: TextAlign.center,
                                    ),
                                  ]
                              ),
                            ),
                          ),
                        ),
                      );
                    }
                  },
                );
  }
}
