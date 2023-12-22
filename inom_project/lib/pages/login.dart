import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:inom_project/models/CustomTextFormField.dart';
import 'package:inom_project/models/PasswordField.dart';
import 'package:inom_project/models/PrimaryButton.dart';
import 'package:inom_project/pages/home.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = "login";
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool obscureText = true;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xffD8F2F0),
        body: ListView(
          children: [
            const SizedBox(
              height: 40.0,
            ),
            Logo(),
            Login_fields(),
          ],
        ),
      ),
    );
  }

  Column Logo() {
    return Column(
      children: [
        SvgPicture.asset(
          'assets/icons/globe.svg',
          height: 200,
        ),
        const SizedBox(
          height: 10.0,
        ),
        const Text(
          'GEOEXPLORER',
          style: TextStyle(
            fontFamily: 'Pulchella',
            fontSize: 38,
            color: Color(0xFF0F2D40),
          ),
        )
      ],
    );
  }

  Container Login_fields() {
    return Container(
      alignment: Alignment.topCenter,
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 20.0,
            ),
            const CustomTextFormField(
              labelText: "Email Address",
              hintText: "Enter a valid email",
              iconData: Icons.email,
              textInputType: TextInputType.emailAddress,
            ),
            const SizedBox(
              height: 20.0,
            ),
            PasswordField(
              labelText: "Password",
              hintText: "Enter your password",
              iconData: Icons.lock,
              obscureText: obscureText,
              onTap: setPasswordVisibility,
            ),
            const SizedBox(
              height: 20.0,
            ),
            PrimaryButton(
              text: "Login",
              iconData: Icons.login,
              onPressed: login,
            ),
            const SizedBox(
              height: 20.0,
            ),
          ],
        ),
      ),
    );
  }

  void login() {
    Navigator.pushNamedAndRemoveUntil(
      context,
      Home.routeName,
      (route) => false, // This will remove all previous routes from the stack
    );
  }

  void setPasswordVisibility() {
    setState(() {
      obscureText = !obscureText;
    });
  }
}
