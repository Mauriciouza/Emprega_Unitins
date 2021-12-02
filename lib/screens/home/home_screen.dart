import 'package:flutter/material.dart';
import 'package:emprega_unitins/constants.dart';
import 'package:emprega_unitins/screens/profile/profile_screen.dart';
import 'package:emprega_unitins/screens/sign_in/sign_in_screen.dart';
import 'package:emprega_unitins/screens/suas_vagas/suas_vagas.dart';
import 'dart:async';
import 'components/body.dart';

class HomeScreen extends StatefulWidget {
  static String routeName = "/home";
  String id;
  HomeScreen({this.id});
  @override
  _HomeScreenState createState() => _HomeScreenState();
}
class _HomeScreenState extends State<HomeScreen> {

  FutureOr naVolta(dynamic value){
    setState(() {

    });
  }

  @override
  String id;
  Widget build(BuildContext context) {
    id = widget.id;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        backgroundColor: kPrimaryColor,
        centerTitle: true,
        title: const Text(
          'Vagas disponíveis',
          style: TextStyle(color: Colors.white),
        ),
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
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen(id: id))),
            ),
            ListTile(
              hoverColor: kPrimaryLightColor,
              leading: Icon(Icons.account_circle),
              title: Text('Perfil'),
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileScreen(id: id))),
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
          Navigator.push(context, MaterialPageRoute(builder: (context) => SuasVagas(id: id))).then(naVolta);
        },
        child: const Icon(Icons.filter_alt_outlined),
        backgroundColor: kPrimaryColor,
      ),
    );
  }
}

