import 'package:flutter/widgets.dart';
import 'package:emprega_unitins/screens/complete_profile/complete_profile_screen.dart';
import 'package:emprega_unitins/screens/forgot_password/forgot_password_screen.dart';
import 'package:emprega_unitins/screens/home/home_screen.dart';
import 'package:emprega_unitins/screens/profile/profile_screen.dart';
import 'package:emprega_unitins/screens/sign_in/sign_in_screen.dart';
import 'package:emprega_unitins/screens/splash/splash_screen.dart';
import 'package:emprega_unitins/screens/complete_exp_prof/components/exp_prof_cad.dart';
import 'package:emprega_unitins/screens/complete_exp_prof/complete_exp_prof_screen.dart';
import 'package:emprega_unitins/screens/complete_form_acad/components/form_acad_cad.dart';
import 'package:emprega_unitins/screens/complete_form_acad/complete_form_acad_screen.dart';
import 'package:emprega_unitins/screens/complete_hab_add/components/hab_add_cad.dart';
import 'package:emprega_unitins/screens/complete_hab_add/complete_hab_add_screen.dart';
import 'package:emprega_unitins/screens/complete_empresa/complete_empresa.dart';
import 'package:emprega_unitins/screens/home_empresa/home_empresa.dart';
import 'package:emprega_unitins/screens/cadastro_vaga/cadastro_vaga.dart';


import 'screens/sign_up/sign_up_screen.dart';

// We use name route
// All our routes will be available here
final Map<String, WidgetBuilder> routes = {
  SplashScreen.routeName: (context) => SplashScreen(),
  SignInScreen.routeName: (context) => SignInScreen(),
  ForgotPasswordScreen.routeName: (context) => ForgotPasswordScreen(),
  SignUpScreen.routeName: (context) => SignUpScreen(),
  CompleteProfileScreen.routeName: (context) => CompleteProfileScreen(),
  CompleteExpProfScreen.routeName: (context) => CompleteExpProfScreen(),
  CompleteFormAcadScreen.routeName: (context) => CompleteFormAcadScreen(),
  CompleteHabAddScreen.routeName: (context) => CompleteHabAddScreen(),
  HomeScreen.routeName: (context) => HomeScreen(),
  HomeEmpresa.routeName: (context) => HomeEmpresa(),
  CadastroVaga.routeName: (context) => CadastroVaga(),
  ProfileScreen.routeName: (context) => ProfileScreen(),
  CompleteEmpresa.routeName: (context) => CompleteEmpresa(),
  ExpProfCad.routeName: (context) => ExpProfCad(),
  FormAcadCad.routeName: (context) => FormAcadCad(),
  HabAddCad.routeName: (context) => HabAddCad(),
};
