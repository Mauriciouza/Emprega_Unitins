import 'package:flutter/material.dart';
import 'package:emprega_unitins/components/default_button.dart';
import 'package:emprega_unitins/components/form_error.dart';

import 'package:emprega_unitins/screens/home/home_screen.dart';
import 'package:emprega_unitins/screens/cadastro_empresa/cadastro_empresa.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:convert' as convert;

import '../../../constants.dart';
import '../../../size_config.dart';


class SignUpForm extends StatefulWidget {
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

enum SingingCharacter { aluno, empresa }

class _SignUpFormState extends State<SignUpForm> {
  final maskFormatter = MaskTextInputFormatter(mask: '###.###.###-##', filter: { "#": RegExp(r'[0-9]') });
  final maskFormatterphone = MaskTextInputFormatter(mask: '(##)#####-####', filter: { "#": RegExp(r'[0-9]') });
  final _formKey = GlobalKey<FormState>();
  bool isHidden = true;
  bool isHidden2 = true;
  String email;
  String cpf;
  String id;
  String telefone;
  String name;
  String senha;
  String confirma_senha;
  String tipo="0";
  bool remember = false;
  final List<String> errors = [];

  SingingCharacter _character = SingingCharacter.aluno;

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
    var url = Uri.parse(caminho+'register.php');
    if(tipo==null)tipo="0";
    var response = await http.post(url,
        body: {
          "nome": name,
          "email": email,
          "cpf": cpf,
          "senha": senha,
          "telefone": telefone,
          "tipo": tipo,
        });
    var data = convert.jsonDecode(response.body);
    if (data["tipo"] == "0") {
      Fluttertoast.showToast(
        msg: "Cadastro feito com sucesso $name",
        textColor: Colors.green,
        fontSize: 25,
      );
      Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen(id: data["id"])));
    }
    if (data["tipo"] == "1") {
      Fluttertoast.showToast(
        msg: "Cadastro feito com sucesso $name",
        textColor: Colors.green,
        fontSize: 25,
      );
      Navigator.push(context, MaterialPageRoute(builder: (context) => CadastroEmpresa(id: data["id"])));
    }
    if(data == "Error"){
      Fluttertoast.showToast(
        msg: "CPF já cadastrado!",
        textColor: Colors.red,
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

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          buildNameFormField(),
          SizedBox(height: getProportionateScreenHeight(8)),
          buildEmailFormField(),
          SizedBox(height: getProportionateScreenHeight(8)),
          buildTelefoneFormField(),
          SizedBox(height: getProportionateScreenHeight(8)),
          buildCPFFormField(),
          SizedBox(height: getProportionateScreenHeight(8)),
          buildPasswordFormField(),
          SizedBox(height: getProportionateScreenHeight(8)),
          buildConformPassFormField(),
          SizedBox(height: getProportionateScreenHeight(8)),
          Row(
            children: <Widget>[
              Expanded(
                child: ListTile(
                  title: Row(
                    children: <Widget>[
                      Radio(
                        value: SingingCharacter.aluno,
                        groupValue: _character,
                        onChanged: (SingingCharacter value) {
                          setState(() {
                            _character = value;
                            tipo = '0';
                          });
                        },
                      ),
                      const Text('Aluno'),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: ListTile(
                  title: Row(
                    children: <Widget>[
                      Radio(
                        value: SingingCharacter.empresa,
                        groupValue: _character,
                        onChanged: (SingingCharacter value) {
                          setState(() {
                            _character = value;
                            tipo = '1';
                          });
                        },
                      ),
                      Text('Empresa'),
                    ],
                  ),
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
                cadastro();
              }
            },
          ),
        ],
      ),
    );
  }

  TextFormField buildConformPassFormField() {
    return TextFormField(
      obscureText: isHidden2,
      //var output = sha256.convert(utf8.encode(input)).toString()
      onSaved: (newValue) => confirma_senha = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPassNullError);
        } else if (value.isNotEmpty && senha == confirma_senha) {
          removeError(error: kMatchPassError);
        }
        confirma_senha = value;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kPassNullError);
          return "";
        } else if ((senha != value)) {
          addError(error: kMatchPassError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Confirme a senha",
        hintText: "Digite sua senha novamente",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: IconButton(
          icon: Icon(isHidden2 ? Icons.visibility_off : Icons.visibility),
          onPressed:(){
            toogle2();
          },
        ),
      ),
    );
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
      obscureText: isHidden,
      onSaved: (newValue) => senha = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPassNullError);
        } else if (value.length >= 8) {
          removeError(error: kShortPassError);
        }
        senha = value;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kPassNullError);
          return "";
        } else if (value.length < 8) {
          addError(error: kShortPassError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Senha",
        hintText: "Informe sua senha",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: IconButton(
          icon: Icon(isHidden ? Icons.visibility_off : Icons.visibility),
          onPressed:(){
            toogle();
          },
        ),
      ),
    );
  }

  TextFormField buildCPFFormField() {
    return TextFormField(
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
        suffixIcon: Icon(Icons.description_outlined),
      ),
    );
  }

  TextFormField buildTelefoneFormField() {
    return TextFormField(
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

  TextFormField buildEmailFormField() {
    return TextFormField(
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

  TextFormField buildNameFormField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      onSaved: (newValue) => name = newValue,
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
  void toogle(){
    isHidden = !isHidden;
    setState(() {});
  }
  void toogle2(){
    isHidden2 = !isHidden2;
    setState(() {});
  }
}
