import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:emprega_unitins/components/default_button.dart';
import 'package:emprega_unitins/components/form_error.dart';
import '../../../constants.dart';
import '../../../size_config.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:convert';
import 'dart:async';
import 'package:emprega_unitins/models/Endereco.dart';

class DadosEndereco extends StatefulWidget {
  String id;
  DadosEndereco({this.id});

  @override
  _DadosEnderecoState createState() => _DadosEnderecoState();
}

class _DadosEnderecoState extends State<DadosEndereco>{

  Future<Endereco> endereco;

  void initState(){
    super.initState();
    endereco=leitura(widget.id);
  }

  final _formKey = GlobalKey<FormState>();

  String cidade=null;
  String UF=null;
  String complemento=null;
  String bairro=null;
  String rua=null;
  String numero=null;

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

  Future<Endereco> atualizar() async {
    var url = Uri.parse(caminho+'atualizarendereco.php');
    var response = await http.post(url,
        body: {
          "id": widget.id,
          "cidade": cidade,
          "UF": UF,
          "complemento": complemento,
          "bairro": bairro,
          "rua": rua,
          "numero": numero,
        });
    var data = jsonDecode(response.body);
    if (data == "0") {
      Fluttertoast.showToast(
        msg: "Endereço atualizado com sucesso",
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

  Future<Endereco> leitura(String id) async {

    var url = Uri.parse(caminho+'dadosendereco.php');
    var response = await http.post(url,
        body: {
          "id": id,
        });
    var data = jsonDecode(response.body);
    if (data!="Vazio") {
      Fluttertoast.showToast(
        msg: "Informações carregadas com sucesso",
        textColor: Colors.green,
        fontSize: 25,
      );
      Endereco dados = Endereco.fromJson(data);
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

  void Inicializar(Endereco endereco) {
    cidade=endereco.cidade;
    UF=endereco.UF;
    complemento=endereco.complemento;
    bairro=endereco.bairro;
    rua=endereco.rua;
    numero=endereco.numero;
  }

  Widget build(BuildContext context) {
    return FutureBuilder<Endereco>(
      future: leitura(widget.id),
      builder: (context, snapshot){
        if(snapshot.hasData) {
          Inicializar(snapshot.data);
          return Form(
            key: _formKey,
            child: Column(
              children: [
                buildBairroFormField(),
                SizedBox(height: getProportionateScreenHeight(8)),
                buildRuaFormField(),
                SizedBox(height: getProportionateScreenHeight(8)),
                buildNumeroFormField(),
                SizedBox(height: getProportionateScreenHeight(8)),
                buildComplementoFormField(),
                SizedBox(height: getProportionateScreenHeight(8)),

                buildCidadeFormField(),
                SizedBox(height: getProportionateScreenHeight(8)),
                buildUFFormField(),
                SizedBox(height: getProportionateScreenHeight(8)),

                FormError(errors: errors),
                SizedBox(height: getProportionateScreenHeight(20)),
                DefaultButton(
                  text: "Continue",
                  press: () {
                    if (_formKey.currentState.validate()) {
                      _formKey.currentState.save();
                      atualizar();
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

  TextFormField buildUFFormField() {
    return TextFormField(
      initialValue: UF,
      keyboardType: TextInputType.emailAddress,
      onSaved: (newValue) => UF = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kUFNullError);
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kUFNullError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "UF",
        hintText: "Informe a UF",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Icon(Icons.flag),
      ),
    );
  }

  TextFormField buildCidadeFormField() {
    return TextFormField(
      initialValue: cidade,
      keyboardType: TextInputType.emailAddress,
      onSaved: (newValue) => cidade = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kCidadeNullError);
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kCidadeNullError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Cidade",
        hintText: "Informe a cidade",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Icon(Icons.home_work_outlined),
      ),
    );
  }

  TextFormField buildBairroFormField() {
    return TextFormField(
      initialValue: bairro,
      keyboardType: TextInputType.emailAddress,
      onSaved: (newValue) => bairro = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kBairroNullError);
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kBairroNullError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Bairro",
        hintText: "Informe o bairro",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Icon(Icons.holiday_village),
      ),
    );
  }

  TextFormField buildNumeroFormField() {
    return TextFormField(
      initialValue: numero,
      keyboardType: TextInputType.emailAddress,
      onSaved: (newValue) => numero = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kNumeroNullError);
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kNumeroNullError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Número",
        hintText: "Informe o número",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Icon(Icons.house),
      ),
    );
  }

  TextFormField buildComplementoFormField() {
    return TextFormField(
      initialValue: complemento,
      keyboardType: TextInputType.emailAddress,
      onSaved: (newValue) => complemento = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          //removeError(error: kNameNullError);
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          //addError(error: kNameNullError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Complemento",
        hintText: "Informe o complemento",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Icon(Icons.person),
      ),
    );
  }

  TextFormField buildRuaFormField() {
    return TextFormField(
      initialValue: rua,
      keyboardType: TextInputType.emailAddress,
      onSaved: (newValue) => rua = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kRuaNullError);
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kRuaNullError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Rua",
        hintText: "Informe a rua",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Icon(Icons.add_road),
      ),
    );
  }

}
