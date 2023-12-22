import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:inom_project/models/PrimaryButton.dart';
import 'package:inom_project/pages/login.dart';

class Settings extends StatefulWidget {
  static const String routeName = "UserProfile";

  const Settings({super.key});
  @override
  _Settings createState() => _Settings();
}

class _Settings extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
        backgroundColor: const Color(0xFF3E8C84),
      ),
      body: settingsContent(),
    );
  }

  Center settingsContent() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(
            height: 40.0,
          ),
          SvgPicture.asset(
            'assets/icons/repair.svg',
            height: 200,
            color: const Color(0xFF0F2D40),
          ),
          const SizedBox(
            height: 20.0,
          ),
          const Text(
            'Sorry! This feature is still under maintenance!',
            style: TextStyle(
              fontSize: 15,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 40.0,
          ),
          SizedBox(
            width: 180,
            child: PrimaryButton(
              text: "Logout",
              iconData: Icons.logout,
              onPressed: logout,
            ),
          ),
        ],
      ),
    );
  }

  void logout() {
    Navigator.pushReplacementNamed(context, LoginScreen.routeName);
  }
}
