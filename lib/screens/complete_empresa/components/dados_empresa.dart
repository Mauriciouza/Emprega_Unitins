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
import 'package:emprega_unitins/models/Empresa.dart';

class DadosEmpresa extends StatefulWidget {
  String id;
  DadosEmpresa({this.id});

  @override
  _DadosEmpresaState createState() => _DadosEmpresaState();
}

class _DadosEmpresaState extends State<DadosEmpresa>{

  Future<Empresa> empresa;

  void initState(){
    super.initState();
    empresa=leitura(widget.id);

  }

  final maskFormatterCNPJ = MaskTextInputFormatter(mask: '##.###.###/####-##', filter: { "#": RegExp(r'[0-9]') });
  final maskFormatterphone = MaskTextInputFormatter(mask: '(##)#####-####', filter: { "#": RegExp(r'[0-9]') });
  final _formKey = GlobalKey<FormState>();

  String email;
  String telefone;
  String nome_fantasia;
  String cnpj;
  String razao_social;

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

  Future<Empresa> atualizar() async {
    var url = Uri.parse(caminho+'atualizarempresa.php');
    var response = await http.post(url,
        body: {
          "id": widget.id,
          "nome_fantasia": nome_fantasia,
          "email": email,
          "cnpj": cnpj,
          "razao_social": razao_social,
          "telefone": telefone,
        });
    var data = jsonDecode(response.body);
    if (data == "0") {
      Fluttertoast.showToast(
        msg: "Cadastro atualizado com sucesso",
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

  Future<Empresa> leitura(String id) async {

    var url = Uri.parse(caminho+'dadosempresa.php');
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
      Empresa dados = Empresa.fromJson(data);
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

  void Inicializar(Empresa empresa) {
    email=empresa.email;
    telefone=empresa.telefone;
    nome_fantasia=empresa.nome_fantasia;
    cnpj=empresa.cnpj;
    razao_social=empresa.razao_social;
  }

  Widget build(BuildContext context) {
    return FutureBuilder<Empresa>(
      future: leitura(widget.id),
      builder: (context, snapshot){
        if(snapshot.hasData) {
          Inicializar(snapshot.data);
          return Form(
            key: _formKey,
            child: Column(
              children: [
                buildNomeFantasiaFormField(),
                SizedBox(height: getProportionateScreenHeight(8)),
                buildCNPJFormField(),
                SizedBox(height: getProportionateScreenHeight(8)),
                buildRazaoSocialFormField(),
                SizedBox(height: getProportionateScreenHeight(8)),
                buildTelefoneFormField(),
                SizedBox(height: getProportionateScreenHeight(8)),
                buildEmailFormField(),
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

  TextFormField buildEmailFormField() {
    return TextFormField(
      initialValue: email,
      keyboardType: TextInputType.emailAddress,
      onSaved: (newValue) => email = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kEmailNullError);
        } else if (emailValidatorRegExp.hasMatch(value)) {
          removeError(error: kInvalidEmailError);
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kEmailNullError);
          return "";
        } else if (!emailValidatorRegExp.hasMatch(value)) {
          addError(error: kInvalidEmailError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Email",
        hintText: "Informe seu email",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Icon(Icons.mail),
      ),
    );
  }

  TextFormField buildTelefoneFormField() {
    return TextFormField(
      initialValue: telefone,
      inputFormatters: [maskFormatterphone],
      keyboardType: TextInputType.number,
      onSaved: (newValue) => telefone = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPhoneNumberNullError);
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kPhoneNumberNullError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Telefone",
        hintText: "Informe seu telefone",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Icon(Icons.phone),
      ),
    );
  }

  TextFormField buildRazaoSocialFormField() {
    return TextFormField(
      initialValue: razao_social,
      keyboardType: TextInputType.emailAddress,
      onSaved: (newValue) => razao_social = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kRazaoSocialNullError);
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kRazaoSocialNullError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Razão Social",
        hintText: "Informe a razão social",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Icon(Icons.account_balance_outlined),
      ),
    );
  }

  TextFormField buildCNPJFormField() {
    return TextFormField(
      initialValue: cnpj,
      inputFormatters: [maskFormatterCNPJ],
      keyboardType: TextInputType.number,
      onSaved: (newValue) => cnpj = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kCNPJNullError);
        } else if (cnpjValidator.hasMatch(value)) {
          removeError(error: kInvalidCNPJError);
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kCNPJNullError);
          return "";
        } else if (!cnpjValidator.hasMatch(value)) {
          addError(error: kInvalidCNPJError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "CNPJ",
        hintText: "Informe o CNPJ",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Icon(Icons.description_outlined)
      ),
    );
  }

  TextFormField buildNomeFantasiaFormField() {
    return TextFormField(
      initialValue: nome_fantasia,
      keyboardType: TextInputType.emailAddress,
      onSaved: (newValue) => nome_fantasia = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kNomeFantasiaNullError);
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kNomeFantasiaNullError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Nome Fantasia",
        hintText: "Informe o nome fantasia",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Icon(Icons.person),
      ),
    );
  }
}
