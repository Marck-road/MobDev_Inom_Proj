import 'package:flutter/material.dart';
import 'package:inom_project/pages/login.dart';
import 'package:inom_project/pages/routes.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: const LoginScreen(),
    theme: ThemeData(fontFamily: 'Poppins'),
    routes: routes,
  ));
}
