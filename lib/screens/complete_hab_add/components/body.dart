import 'package:flutter/material.dart';
import 'package:emprega_unitins/constants.dart';
import 'package:emprega_unitins/size_config.dart';
import 'package:emprega_unitins/models/Habs.dart';
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
  Future<List<Habs>> habs;

  void initState() {
    String id=widget.id;
    super.initState();
    habs = getHabsList();
  }

  Future<List<Habs>> getHabsList() async {
    List<Habs> dados;
    var url = Uri.parse(caminho+'habs.php');
    var response = await http.post(url,body:{"id": widget.id,});
    var data = json.decode(response.body);
    if (data != "Vazio") {
      dados = List<Habs>.from(
          data.map((model) => Habs.fromJson(model)));
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

  void refreshHabsList() {
    setState(() {
      habs = getHabsList();
    });
  }


  Widget build(BuildContext context) {
                return FutureBuilder<List<Habs>>(
                  initialData: [],
                  future: getHabsList(),
                  builder: (context, snapshot) {
                    if(snapshot.hasData) {
                      return ListView.builder(
                          itemCount: snapshot.data.length,
                          itemBuilder: (BuildContext context, int index) {
                            var data = snapshot.data[index];
                            var habilidade = data.habilidade;
                            var nivel = data.nivel;
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
                                            title: Text("Habilidade: $habilidade"),
                                            subtitle: Text("Nivel: $nivel"),
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: <Widget>[
                                              TextButton(
                                                child: const Text('Detalhes'),
                                                onPressed: () { },
                                              ),
                                              const SizedBox(width: 8),
                                              TextButton(
                                                child: const Text('Remover'),
                                                onPressed: () { },
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
                                      "Adicione uma habilidade adicional",
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
