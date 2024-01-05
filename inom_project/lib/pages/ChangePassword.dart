import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:inom_project/models/FilledTextForm.dart';
import 'package:inom_project/models/PasswordField.dart';
import 'package:inom_project/models/PrimaryButton.dart';

class ChangePassword extends StatefulWidget {
  static const String routeName = "ChangePassword";

  const ChangePassword({super.key});
  @override
  _ChangePassword createState() => _ChangePassword();
}

class _ChangePassword extends State<ChangePassword> {
  TextEditingController emailController = TextEditingController();
  TextEditingController currentPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();

  bool obscureText = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Change Password"),
        backgroundColor: const Color(0xFF3E8C84),
      ),
      body: changePassContent(),
    );
  }

  Center changePassContent() {
    final user = FirebaseAuth.instance.currentUser!;
    User? currentUser = FirebaseAuth.instance.currentUser;
    GoogleSignInAccount? googleSignInAccount = GoogleSignIn().currentUser;

    return Center(
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
                  color: const Color(0xFF93dbd6),
                  height: 120,
                ),
          const SizedBox(
            height: 40.0,
          ),
          const SizedBox(
            height: 20.0,
          ),
          FilledTextForm(
            value: currentUser?.email,
            labelText: "Email Address",
            iconData: Icons.email,
          ),
          const SizedBox(
            height: 20.0,
          ),
          PasswordField(
            labelText: "Current Password",
            hintText: "Enter your password",
            iconData: Icons.lock,
            obscureText: obscureText,
            onTap: setPasswordVisibility,
            controller: currentPasswordController,
          ),
          const SizedBox(
            height: 20.0,
          ),
          PasswordField(
            labelText: "New Password",
            hintText: "Enter your password",
            iconData: Icons.lock,
            obscureText: obscureText,
            onTap: setPasswordVisibility,
            controller: newPasswordController,
          ),
          const SizedBox(
            height: 20.0,
          ),
          PrimaryButton(
            text: "Change Password",
            iconData: Icons.logout,
            onPressed: () {
              _changePassword(
                currentUser,
                currentPasswordController.value.text,
                newPasswordController.value.text,
              );
            },
          ),
          const SizedBox(
            height: 20.0,
          ),
        ],
      ),
    );
  }

  void setPasswordVisibility() {
    setState(() {
      obscureText = !obscureText;
    });
  }

  Future<void> _changePassword(
      User? currentUser, String currentPassword, String newPassword) async {
    //Pass in the password to updatePassword.
    final user = await FirebaseAuth.instance.currentUser;

    final cred = EmailAuthProvider.credential(
      email: currentUser!.email!,
      password: currentPassword!,
    );

    await currentUser.reauthenticateWithCredential(cred);

    await currentUser.updatePassword(newPassword);

    currentUser?.updatePassword(newPassword).then((_) {
      print("Successfully changed password");
    }).catchError((error) {
      print("Password can't be changed" + error.toString());
      //This might happen, when the wrong password is in, the user isn't found, or if the user hasn't logged in recently.
    });
  }
}
