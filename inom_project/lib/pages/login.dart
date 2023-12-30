import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:inom_project/models/CustomTextFormField.dart';
import 'package:inom_project/models/PasswordField.dart';
import 'package:inom_project/models/PrimaryButton.dart';
import 'package:inom_project/models/StrorageItem.dart';
import 'package:inom_project/pages/SignUp.dart';
import 'package:inom_project/pages/home.dart';
import 'package:inom_project/services/StorageService.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = "login";
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  StorageService storageService = StorageService();
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
              text: "Login",
              iconData: Icons.login,
              onPressed: () {
                signIn(
                  context,
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
                Text("New to the app?"),
                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacementNamed(
                      context,
                      SignUpPage.routeName,
                    );
                  },
                  child: Text(
                    "Sign up Here!",
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
    );
  }

  Future<void> signIn(context, String email, String password) async {
    try {
      UserCredential credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      var item = StorageItem("uid", credential.user?.uid ?? "");
      await storageService.saveData(item);

      await Navigator.pushNamedAndRemoveUntil(
        context,
        Home.routeName,
        (route) => false, // This will remove all previous routes from the stack
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
