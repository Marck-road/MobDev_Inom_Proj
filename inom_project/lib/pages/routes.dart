import 'package:flutter/material.dart';
import 'package:inom_project/pages/ChangePassword.dart';
import 'package:inom_project/pages/Dashboard.dart';
import 'package:inom_project/pages/FirstChangePass.dart';
import 'package:inom_project/pages/Home.dart';
import 'package:inom_project/pages/Login.dart';
import 'package:inom_project/pages/SavedDrinks.dart';
import 'package:inom_project/pages/SignUp.dart';
import 'package:inom_project/pages/UserProfile.dart';

final Map<String, WidgetBuilder> routes = {
  LoginScreen.routeName: (BuildContext context) => const LoginScreen(),
  Dashboard.routeName: (BuildContext context) => const Dashboard(),
  SavedDrinks.routeName: (BuildContext context) => const SavedDrinks(),
  UserProfile.routeName: (BuildContext context) => const UserProfile(),
  ChangePassword.routeName: (BuildContext context) => const ChangePassword(),
  FirstChangePass.routeName: (BuildContext context) => const FirstChangePass(),
  Home.routeName: (BuildContext context) => const Home(),
  SignUpPage.routeName: (BuildContext context) => const SignUpPage(),
};
