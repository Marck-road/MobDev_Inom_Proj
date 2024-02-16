import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:inom_project/models/CustomTextFormField.dart';
import 'package:inom_project/models/LoginButton.dart';
import 'package:inom_project/models/PasswordField.dart';
import 'package:inom_project/models/StrorageItem.dart';
import 'package:inom_project/pages/FirstChangePass.dart';
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
        backgroundColor: const Color(0xFF450920),
        body: ListView(
          children: [
            const SizedBox(
              height: 10.0,
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
        const SizedBox(
          height: 20.0,
        ),
        Image.asset(
          'assets/pictures/kanpaiLogo.png',
          height: 250,
        ),
        const SizedBox(
          height: 5.0,
        ),
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
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 170,
                  height: 52,
                  child: LoginButton(
                    text: "Login",
                    iconData: Icons.login,
                    onPressed: () {
                      emailPasswordLogin(
                        context,
                        emailController.value.text,
                        passwordController.value.text,
                      );
                    },
                    textSize: 17,
                  ),
                ),
                const SizedBox(
                  width: 20.0,
                ),
                SizedBox(
                  width: 170,
                  height: 52,
                  child: LoginButton(
                    text: "Sign In with Google",
                    iconData: null,
                    onPressed: () {
                      googleLogin();
                    },
                    textSize: 12,
                    uniqueIcon: 'assets/icons/google.svg',
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 30.0,
            ),
            Row(
              children: [
                const SizedBox(
                  width: 6,
                ),
                const Text(
                  "New to the app? ",
                  style: TextStyle(
                    color: Color(0xFFce4257),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacementNamed(
                      context,
                      SignUpPage.routeName,
                    );
                  },
                  child: const Text(
                    "Sign up Here!",
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
    );
  }

  Future<void> emailPasswordLogin(
      context, String email, String password) async {
    try {
      UserCredential credential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      var item = StorageItem("uid", credential.user?.uid ?? "");
      await storageService.saveData(item);

      User? currentUser = FirebaseAuth.instance.currentUser;

      await Navigator.pushNamedAndRemoveUntil(
        context,
        Home.routeName,
        (route) => false,
      );
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Error logging in. Please try again.'),
          duration: Duration(seconds: 3),
        ),
      );
      print(e.message);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Error logging in. Please try again.'),
          duration: Duration(seconds: 3),
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

  googleLogin() async {
    bool firstTime = false;

    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      if (googleUser == null) return;

      var item = StorageItem("uid", googleUser.id ?? "");
      await storageService.saveData(item);

      try {
        //Create E/P Account using user's email and a default password
        UserCredential userPassCredential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: googleUser.email,
          password: "123456",
        );
        firstTime = true;
      } catch (e) {
        firstTime = false;

        print(e);
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      User? currentUser = FirebaseAuth.instance.currentUser;

      try {
        await currentUser?.linkWithCredential(credential);
      } catch (e) {
        firstTime = false;
        print(e);
      }

      UserCredential? userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      if (firstTime == true) {
        // ignore: use_build_context_synchronously
        await Navigator.pushNamedAndRemoveUntil(
          context,
          FirstChangePass.routeName,
          (route) =>
              false, // This will remove all previous routes from the stack
        );
      }

      // ignore: use_build_context_synchronously
      await Navigator.pushNamedAndRemoveUntil(
        context,
        Home.routeName,
        (route) => false, // This will remove all previous routes from the stack
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Error logging in. Please try again.'),
          duration: Duration(seconds: 3), // You can customize the duration
        ),
      );
      print(e);
    }
  }
}
