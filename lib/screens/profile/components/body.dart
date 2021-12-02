import 'package:emprega_unitins/screens/complete_exp_prof/complete_exp_prof_screen.dart';
import 'package:emprega_unitins/screens/complete_form_acad/complete_form_acad_screen.dart';
import 'package:emprega_unitins/screens/complete_hab_add/complete_hab_add_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:emprega_unitins/screens/complete_profile/complete_profile_screen.dart';

import 'profile_menu.dart';

class Body extends StatelessWidget {
  String id;
  Body({this.id});
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          SizedBox(height: 20),
          ProfileMenu(
            text: "Dados básicos",
            icon: "assets/icons/User Icon.svg",
            press: () => Navigator.push(context, MaterialPageRoute(builder: (context) => CompleteProfileScreen(id: id))),
          ),
          ProfileMenu(
            text: "Experiência profissional",
            icon: "assets/icons/Bell.svg",
            press: () => Navigator.push(context, MaterialPageRoute(builder: (context) => CompleteExpProfScreen(id: id))),
          ),
          ProfileMenu(
            text: "Formação acadêmica",
            icon: "assets/icons/Settings.svg",
            press: () => Navigator.push(context, MaterialPageRoute(builder: (context) => CompleteFormAcadScreen(id: id))),
          ),
          ProfileMenu(
            text: "Habilidades adicionais",
            icon: "assets/icons/Question mark.svg",
            press: () => Navigator.push(context, MaterialPageRoute(builder: (context) => CompleteHabAddScreen(id: id))),
          ),
        ],
      ),
    );
  }
}
