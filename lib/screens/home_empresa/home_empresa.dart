import 'package:flutter/material.dart';
import 'package:emprega_unitins/constants.dart';
import 'package:emprega_unitins/screens/profile_empresa/profile_empresa.dart';
import 'package:emprega_unitins/screens/cadastro_vaga/cadastro_vaga.dart';
import 'package:emprega_unitins/screens/sign_in/sign_in_screen.dart';
import 'package:emprega_unitins/screens/vagas_antigas/vagas_antigas.dart';
import 'dart:async';
import 'components/body.dart';

class HomeEmpresa extends StatefulWidget {
  static String routeName = "/home_empresa";
  String id;
  HomeEmpresa({this.id});
  @override
  _HomeEmpresaState createState() => _HomeEmpresaState();
}
class _HomeEmpresaState extends State<HomeEmpresa> {

  FutureOr naVolta(dynamic value){
    setState(() {
    });
  }

  String id;
  Widget build(BuildContext context) {
    id=widget.id;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        backgroundColor: kPrimaryColor,
        centerTitle: true,
        title: const Text(
          'Vagas Disponíveis',
          style: TextStyle(color: Colors.white),
        ),
        actions: [IconButton(
          icon: Icon(Icons.add),
          tooltip: 'Adicione nova vaga',
          onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context) => CadastroVaga(id: id))).then(naVolta);},
        ),]
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            Container(
              height: 120.0,
              child: DrawerHeader(
                  child: Text('Menu', style: TextStyle(color: Colors.white, fontSize: 24)),
                  decoration: BoxDecoration(color: kPrimaryColor),
                  margin: EdgeInsets.all(0.0),
                  padding: EdgeInsets.fromLTRB(10, 30, 10, 10)
              ),
            ),
            ListTile(
              hoverColor: kPrimaryLightColor,
              leading: Icon(Icons.work),
              title: Text('Vagas'),
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => HomeEmpresa(id: id))),
            ),
            ListTile(
              hoverColor: kPrimaryLightColor,
              leading: Icon(Icons.account_circle),
              title: Text('Perfil'),
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileEmpresa(id: id))),
            ),
            ListTile(
              hoverColor: kPrimaryLightColor,
              leading: Icon(Icons.exit_to_app),
              title: Text('Sair'),
              onTap: () => Navigator.of(context).pushNamedAndRemoveUntil(
                  SignInScreen.routeName, (Route<dynamic> route) => false),
            ),
          ],
        ),
      ),
      body: Body(id: id),
      floatingActionButton: new FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => VagasAntigas(id: id))).then(naVolta);
        },
        child: const Icon(Icons.filter_alt_outlined),
        backgroundColor: kPrimaryColor,
      ),
    );
  }
}

