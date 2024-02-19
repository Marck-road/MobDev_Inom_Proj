import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:inom_project/models/PasswordField.dart';
import 'package:inom_project/models/PrimaryButton.dart';
import 'package:inom_project/pages/home.dart';

class FirstChangePass extends StatefulWidget {
  static const String routeName = "FirstChangePassword";

  const FirstChangePass({super.key});
  @override
  _FirstTimeChangePassword createState() => _FirstTimeChangePassword();
}

class _FirstTimeChangePassword extends State<FirstChangePass> {
  TextEditingController emailController = TextEditingController();
  TextEditingController PasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  bool obscureText = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF450920),
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Color(0xFFff9b54), // Set the color for the back button
        ),
        title: const Text(
          "Set up Account",
          style: TextStyle(
            color: Color(0xFFff9b54),
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: const Color(0xFF4f000b),
      ),
      body: changePassContent(),
    );
  }

  Center changePassContent() {
    final user = FirebaseAuth.instance.currentUser!;
    User? currentUser = FirebaseAuth.instance.currentUser;
    GoogleSignInAccount? googleSignInAccount = GoogleSignIn().currentUser;

    return Center(
      child: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 40.0,
                ),
                (currentUser?.providerData[0].photoURL != null)
                    ? CircleAvatar(
                        radius: 65,
                        backgroundImage: NetworkImage(
                          currentUser?.providerData[0].photoURL ?? '',
                        ),
                      )
                    : SvgPicture.asset(
                        'assets/icons/profile.svg',
                        // ignore: deprecated_member_use
                        color: const Color(0xFFff9b54),
                        height: 120,
                      ),
                const SizedBox(
                  height: 20.0,
                ),
                (currentUser?.providerData[0].displayName != null)
                    ? Column(
                        children: [
                          Text(
                            'Name: ${currentUser?.providerData[0].displayName}',
                            style: const TextStyle(
                                fontSize: 15,
                                color: Color(0xFFf9dbbd),
                                fontWeight: FontWeight.w300),
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            'Email: ${currentUser?.email}',
                            style: const TextStyle(
                              fontSize: 15,
                              color: Color(0xFFf9dbbd),
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      )
                    : Text(
                        'Email: ${currentUser?.email}',
                        style: const TextStyle(
                          fontSize: 15,
                          color: Color(0xFFf9dbbd),
                        ),
                        textAlign: TextAlign.center,
                      ),
                const SizedBox(
                  height: 20.0,
                ),
                SizedBox(
                  width: 380,
                  child: PasswordField(
                    labelText: "Password",
                    hintText: "Enter your password",
                    iconData: Icons.lock,
                    obscureText: obscureText,
                    onTap: setPasswordVisibility,
                    controller: PasswordController,
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                SizedBox(
                  width: 380,
                  child: PasswordField(
                    labelText: "Confirm Password",
                    hintText: "Reenter your password",
                    iconData: Icons.lock,
                    obscureText: obscureText,
                    onTap: setPasswordVisibility,
                    controller: confirmPasswordController,
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                SizedBox(
                  width: 240,
                  child: PrimaryButton(
                    text: "Set up Account",
                    iconData: Icons.check,
                    onPressed: () {
                      _changePassword(
                        currentUser,
                        "123456",
                        PasswordController.value.text,
                        confirmPasswordController.value.text,
                      );
                    },
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  void setPasswordVisibility() {
    setState(() {
      obscureText = !obscureText;
    });
  }

  Future<void> _changePassword(User? currentUser, String currentPassword,
      String newPassword, String confPassword) async {
    try {
      if (newPassword != confPassword) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Password does not match.'),
            duration: Duration(seconds: 3),
          ),
        );
        return;
      }

      //Pass in the password to updatePassword.
      final user = await FirebaseAuth.instance.currentUser;

      final cred = EmailAuthProvider.credential(
        email: currentUser!.email!,
        password: currentPassword,
      );

      await currentUser.reauthenticateWithCredential(cred);

      await currentUser.updatePassword(newPassword);

      currentUser.updatePassword(newPassword).then((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Successfully created account!'),
            duration: Duration(seconds: 3),
          ),
        );

        Navigator.pushNamedAndRemoveUntil(
          context,
          Home.routeName,
          (route) =>
              false, // This will remove all previous routes from the stack
        );
      }).catchError((error) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
                'Error setting up password. Please check password credentials'),
            duration: Duration(seconds: 3),
          ),
        );
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
              'Error setting up password. Please check password credentials'),
          duration: Duration(seconds: 3),
        ),
      );
    }
  }
}
