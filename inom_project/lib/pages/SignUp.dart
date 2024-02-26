import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:inom_project/models/CustomTextFormField.dart';
import 'package:inom_project/models/PasswordField.dart';
import 'package:inom_project/models/StrorageItem.dart';
import 'package:inom_project/pages/Home.dart';
import 'package:inom_project/pages/login.dart';
import 'package:inom_project/services/StorageService.dart';

class SignUpPage extends StatefulWidget {
  static const String routeName = "register";
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  StorageService storageService = StorageService();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool obscureText = true;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFF450920),
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
        Image.asset(
          'assets/pictures/kanpaiLogo.png',
          height: 200,
        ),
        const SizedBox(
          height: 10.0,
        ),
        Container(
          // margin: EdgeInsets.only(left: 25.0),
          // alignment: Alignment.centerLeft,
          child: const Text(
            'Create an Account',
            style: TextStyle(
              fontFamily: 'Pulchella',
              fontSize: 38,
              color: Color(0xFFff9b54),
            ),
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
              SizedBox(
                width: 170,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    register(
                      emailController.value.text,
                      passwordController.value.text,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                    backgroundColor: const Color(0xFFce4257),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Sign up",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          color: Color(0xFFefe9e7),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              Row(
                children: [
                  const Text(
                    "Already have an account? ",
                    style: TextStyle(
                      color: Color(0xFFce4257),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacementNamed(
                        context,
                        LoginScreen.routeName,
                      );
                    },
                    child: const Text(
                      "Login",
                      style: TextStyle(
                        color: Color(0xFFff7f51),
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

      // Apparently this shit is not needed
      // UserCredential loginCredentials =
      //     await FirebaseAuth.instance.signInWithEmailAndPassword(
      //   email: email,
      //   password: password,
      // );

      var item = StorageItem("uid", credential.user?.uid ?? "");
      await storageService.saveData(item);

      // ignore: use_build_context_synchronously

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Successfully created account!'),
          duration: Duration(seconds: 3), // You can customize the duration
        ),
      );

      await Navigator.pushNamedAndRemoveUntil(
        context,
        Home.routeName,
        (route) => false, // This will remove all previous routes from the stack
      );
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Error signing up. Please try again.'),
          duration: Duration(seconds: 3), // You can customize the duration
        ),
      );
      print(e.message);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Error signing up. Please try again.'),
          duration: Duration(seconds: 3), // You can customize the duration
        ),
      );
      print(e);
    }
  }

  void setPasswordVisibility() {
    setState(() {
      obscureText = !obscureText;
    });
  }
}
