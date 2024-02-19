import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_sign_in/google_sign_in.dart';
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
  TextEditingController confPasswordController = TextEditingController();

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
          "Change Password",
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
                (currentUser?.providerData[0].displayName != null &&
                        currentUser?.providerData[0].displayName != "")
                    ? Column(
                        children: [
                          Text(
                            '${currentUser?.providerData[0].displayName}',
                            style: const TextStyle(
                                fontSize: 18,
                                color: Color(0xFFf9dbbd),
                                fontWeight: FontWeight.w300),
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            '${currentUser?.email}',
                            style: const TextStyle(
                              fontSize: 18,
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
                  height: 10.0,
                ),
                const SizedBox(
                  height: 20.0,
                ),
                SizedBox(
                  width: 380,
                  child: PasswordField(
                    labelText: "Current Password",
                    hintText: "Enter your password",
                    iconData: Icons.lock,
                    obscureText: obscureText,
                    onTap: setPasswordVisibility,
                    controller: currentPasswordController,
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                SizedBox(
                  width: 380,
                  child: PasswordField(
                    labelText: "New Password",
                    hintText: "Enter your password",
                    iconData: Icons.lock,
                    obscureText: obscureText,
                    onTap: setPasswordVisibility,
                    controller: newPasswordController,
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                SizedBox(
                  width: 380,
                  child: PasswordField(
                    labelText: "Confirm Password",
                    hintText: "Enter your password",
                    iconData: Icons.lock,
                    obscureText: obscureText,
                    onTap: setPasswordVisibility,
                    controller: confPasswordController,
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                SizedBox(
                  width: 240,
                  child: PrimaryButton(
                    text: "Change Password",
                    iconData: Icons.key,
                    onPressed: () {
                      _changePassword(
                        currentUser,
                        currentPasswordController.value.text,
                        newPasswordController.value.text,
                        confPasswordController.value.text,
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
            content: Text('Successfully changed password!'),
            duration: Duration(seconds: 3),
          ),
        );
      }).catchError((error) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
                'Error changing password. Please check password credentials'),
            duration: Duration(seconds: 3),
          ),
        );
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
              'Error changing password. Please check password credentials'),
          duration: Duration(seconds: 3),
        ),
      );
    }
  }
}
