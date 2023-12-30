import 'package:flutter/material.dart';
import 'package:inom_project/pages/Dashboard.dart';
import 'package:inom_project/pages/Home.dart';
import 'package:inom_project/pages/Login.dart';
import 'package:inom_project/pages/Settings.dart';
import 'package:inom_project/pages/SignUp.dart';

final Map<String, WidgetBuilder> routes = {
  LoginScreen.routeName: (BuildContext context) => const LoginScreen(),
  Dashboard.routeName: (BuildContext context) => const Dashboard(),
  Settings.routeName: (BuildContext context) => const Settings(),
  Home.routeName: (BuildContext context) => const Home(),
  SignUpPage.routeName: (BuildContext context) => const SignUpPage(),
};
