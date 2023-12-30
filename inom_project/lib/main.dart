import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:inom_project/firebase_options.dart';
import 'package:inom_project/pages/Dashboard.dart';
import 'package:inom_project/pages/Login.dart';
import 'package:inom_project/pages/routes.dart';
import 'package:inom_project/services/StorageService.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  StorageService storageService = StorageService();

  var item = await storageService.readData("uid");

  if (item != Null) {
    runApp(MaterialApp(
      initialRoute: Dashboard.routeName,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Poppins'),
      routes: routes,
    ));
  } else {
    runApp(MaterialApp(
      initialRoute: LoginScreen.routeName,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Poppins'),
      routes: routes,
    ));
  }
}
