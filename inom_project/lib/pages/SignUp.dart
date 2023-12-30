import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:inom_project/models/CustomTextFormField.dart';
import 'package:inom_project/models/PasswordField.dart';
import 'package:inom_project/models/PrimaryButton.dart';
import 'package:inom_project/pages/login.dart';

class SignUpPage extends StatefulWidget {
  static const String routeName = "register";
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
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
          'KANPAI',
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
        child: Form(
          child: Column(
            children: [
              const SizedBox(
                height: 20.0,
              ),
              CustomTextFormField(
                labelText: "Email Address",
                hintText: "Enter a valid email",
                iconData: Icons.email,
                controller: emailController,
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
                controller: passwordController,
              ),
              const SizedBox(
                height: 20.0,
              ),
              PrimaryButton(
                text: "Sign up",
                iconData: Icons.login,
                onPressed: () {
                  register(
                    emailController.value.text,
                    passwordController.value.text,
                  );
                },
              ),
              const SizedBox(
                height: 20.0,
              ),
              Row(
                children: [
                  Text("Already have an account?"),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacementNamed(
                        context,
                        LoginScreen.routeName,
                      );
                    },
                    child: Text(
                      "Login",
                      style: TextStyle(
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void register(String email, String password) async {
    try {
      UserCredential credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      print(e.message);
    } catch (e) {
      print(e);
    }
  }

  void setPasswordVisibility() {
    setState(() {
      obscureText = !obscureText;
    });
  }
}
