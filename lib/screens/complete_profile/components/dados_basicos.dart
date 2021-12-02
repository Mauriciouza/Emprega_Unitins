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
import 'package:emprega_unitins/models/Pessoa.dart';

class DadosBasicos extends StatefulWidget {
  String id;
  DadosBasicos({this.id});

  @override
  _DadosBasicosState createState() => _DadosBasicosState();
}

enum SingingCharacter { masculino, feminino }

class _DadosBasicosState extends State<DadosBasicos>{

  Future<Pessoa> pessoa;

  void initState(){
    super.initState();
    pessoa = leitura(widget.id);
  }

  final maskFormatter = MaskTextInputFormatter(mask: '###.###.###-##', filter: { "#": RegExp(r'[0-9]') });
  final maskFormatterphone = MaskTextInputFormatter(mask: '(##)#####-####', filter: { "#": RegExp(r'[0-9]') });
  final maskFormatterDtNasc = MaskTextInputFormatter(mask: '##/##/####', filter: { "#": RegExp(r'[0-9]') });
  final _formKey = GlobalKey<FormState>();
  String id=null;
  String email=null;
  String telefone=null;
  String nome=null;
  String cpf=null;
  String dt_nasc=null;
  String sexo="0";
  String tipo=null;

  SingingCharacter _character = SingingCharacter.masculino;

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

  Future atualizar() async {
    var url = Uri.parse(caminho+'atualizar.php');
    if(sexo==null)sexo="0";
    var response = await http.post(url,
        body: {
          "id": id,
          "nome": nome,
          "email": email,
          "cpf": cpf,
          "telefone": telefone,
          "dt_nasc": dt_nasc,
          "sexo": sexo,
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

  Future<Pessoa> leitura(String id) async {
    var url = Uri.parse(caminho+'lerdados.php');
    var response = await http.post(url,
        body: {
          "id": id,
        });
    var data = jsonDecode(response.body);
    if (data["tipo"] == "0") {
      Fluttertoast.showToast(
        msg: "Informações carregadas com sucesso",
        textColor: Colors.green,
        fontSize: 25,
      );
      Pessoa dados = Pessoa.fromJson(data);
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

  void Inicializar(Pessoa pessoa){
    id=pessoa.id;
    email=pessoa.email;
    telefone=pessoa.telefone;
    nome=pessoa.name;
    cpf=pessoa.cpf;
    dt_nasc=pessoa.dt_nasc;
    sexo=pessoa.sexo;
    tipo=pessoa.tipo;
    if(pessoa.sexo=="1")_character = SingingCharacter.feminino;
    else _character = SingingCharacter.masculino;
  }

  Widget build(BuildContext context) {
    return FutureBuilder<Pessoa>(
      future: leitura(widget.id),
      builder: (context, snapshot){
        if(snapshot.hasData) {
          Inicializar(snapshot.data);
          return Form(
            key: _formKey,
            child: Column(
              children: [
                buildNameFormField(nome),
                SizedBox(height: getProportionateScreenHeight(8)),
                buildCPFFormField(cpf),
                SizedBox(height: getProportionateScreenHeight(8)),
                buildDtNascFormField(),
                SizedBox(height: getProportionateScreenHeight(8)),
                buildTelefoneFormField(telefone),
                SizedBox(height: getProportionateScreenHeight(8)),
                buildEmailFormField(email),
                SizedBox(height: getProportionateScreenHeight(8)),

                Column(

                  children: <Widget>[
                    ListTile(
                      visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                      title: const Text('Masculino'),
                      leading: Radio<SingingCharacter>(
                        value: SingingCharacter.masculino,
                        groupValue: _character,
                        onChanged: (SingingCharacter value) {
                          setState(() {
                            _character = value;
                            sexo = "0";
                            if (_formKey.currentState.validate()) {
                              _formKey.currentState.save();
                              atualizar();
                            }
                          });
                        },
                      ),
                    ),
                    ListTile(
                      visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                      title: const Text('Feminino'),
                      leading: Radio<SingingCharacter>(
                        value: SingingCharacter.feminino,
                        groupValue: _character,
                        onChanged: (SingingCharacter value) {
                          setState(() {
                            _character = value;
                            sexo = "1";
                            if (_formKey.currentState.validate()) {
                              _formKey.currentState.save();
                              atualizar();
                            }
                          });
                        },
                      ),
                    ),
                  ],
                ),

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

  TextFormField buildEmailFormField(String email) {
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

  TextFormField buildTelefoneFormField(String telefone) {
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

  TextFormField buildDtNascFormField() {
    return TextFormField(
      initialValue: dt_nasc,
      inputFormatters: [maskFormatterDtNasc],
      keyboardType: TextInputType.number,
      onSaved: (newValue) => dt_nasc = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kDtNascNullError);
        } else if (dtValidator.hasMatch(value)) {
          removeError(error: kInvalidDtNascError);
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kDtNascNullError);
          return "";
        } else if (!dtValidator.hasMatch(value)) {
          addError(error: kInvalidDtNascError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Data de Nascimento",
        hintText: "Informe sua data de nascimento",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Icon(Icons.calendar_today),
      ),
    );
  }

  TextFormField buildCPFFormField(String cpf) {
    return TextFormField(
      initialValue: cpf,
      inputFormatters: [maskFormatter],
      keyboardType: TextInputType.number,
      onSaved: (newValue) => cpf = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kCPFNullError);
        } else if (cpfValidator.hasMatch(value)) {
          removeError(error: kInvalidCPFError);
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kCPFNullError);
          return "";
        } else if (!cpfValidator.hasMatch(value)) {
          addError(error: kInvalidCPFError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "CPF",
        hintText: "Informe seu CPF",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Icon(Icons.description_outlined)
      ),
    );
  }

  TextFormField buildNameFormField(String nome) {
    return TextFormField(
      initialValue: nome,
      keyboardType: TextInputType.emailAddress,
      onSaved: (newValue) => nome = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kNameNullError);
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kNameNullError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Nome",
        hintText: "Informe seu nome",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Icon(Icons.person),
      ),
    );
  }
}
