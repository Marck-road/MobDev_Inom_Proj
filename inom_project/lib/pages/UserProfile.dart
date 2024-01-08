import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:inom_project/models/PrimaryButton.dart';
import 'package:inom_project/pages/ChangePassword.dart';
import 'package:inom_project/pages/Login.dart';
import 'package:inom_project/services/StorageService.dart';

class UserProfile extends StatefulWidget {
  static const String routeName = "UserProfile";

  const UserProfile({super.key});
  @override
  _UserProfile createState() => _UserProfile();
}

class _UserProfile extends State<UserProfile> {
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
            height: 20.0,
          ),
          (currentUser?.providerData[0].displayName != null)
              ? Text(
                  'Welcome back, ${currentUser?.providerData[0].displayName}! \nEmail: ${currentUser?.email}',
                  style: const TextStyle(
                    fontSize: 15,
                  ),
                  textAlign: TextAlign.center,
                )
              : Text(
                  'Email: (${currentUser?.email})!',
                  style: const TextStyle(
                    fontSize: 15,
                  ),
                  textAlign: TextAlign.center,
                ),
          const SizedBox(
            height: 40.0,
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, ChangePassword.routeName);
            },
            child: Container(
              height: 30,
              width: 200, // Set the desired width
              decoration: BoxDecoration(
                color: Colors.blueGrey, // Set the background color here
                borderRadius:
                    BorderRadius.circular(8), // Optional: add rounded corners
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.key,
                  ),
                  SizedBox(
                    width: 8,
                  ), // Optional: add spacing between icon and text
                  Text(
                    'Edit Password',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.white, // Set the text color
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 10.0,
          ),
          isAccountLinked()
              ? Container(
                  height: 30,
                  width: 200, // Set the desired width
                  decoration: BoxDecoration(
                    color: Colors.blueGrey, // Set the background color here
                    borderRadius: BorderRadius.circular(
                        8), // Optional: add rounded corners
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        'assets/icons/google.svg',
                        height: 17,
                      ),
                      const SizedBox(
                        width: 8,
                      ), // Optional: add spacing between icon and text
                      const Text(
                        'Google Account Linked',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.white, // Set the text color
                        ),
                      ),
                      const Icon(
                        Icons.check,
                        color: Colors.green,
                      )
                    ],
                  ),
                )
              : GestureDetector(
                  onTap: () {
                    linkGoogleAccount();
                  },
                  child: Container(
                    height: 30,
                    width: 200, // Set the desired width
                    decoration: BoxDecoration(
                      color: Colors.blueGrey, // Set the background color here
                      borderRadius: BorderRadius.circular(
                          8), // Optional: add rounded corners
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          'assets/icons/google.svg',
                          height: 17,
                        ),
                        const SizedBox(
                          width: 8,
                        ), // Optional: add spacing between icon and text
                        const Text(
                          'Link Google Account',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white, // Set the text color
                          ),
                        ),
                      ],
                    ),
                  ),
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

  Future<void> logout() async {
    StorageService storageService = StorageService();
    storageService.deleteAllData();

    await GoogleSignIn().signOut();
    // await GoogleSignIn().disconnect();
    await FirebaseAuth.instance.signOut();

    print(FirebaseAuth.instance.currentUser);

    Navigator.pushReplacementNamed(context, LoginScreen.routeName);
  }

  bool isAccountLinked() {
    User? currentUser = FirebaseAuth.instance.currentUser;

    bool isGoogleLinked = currentUser != null &&
        !currentUser.isAnonymous &&
        currentUser.providerData.any((info) => info.providerId == 'google.com');

    return isGoogleLinked;
  }

  linkGoogleAccount() async {
    User? currentUser = FirebaseAuth.instance.currentUser;

    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    if (googleUser == null) return;

    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    final googleCredential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    try {
      if (currentUser != null && !currentUser.isAnonymous) {
        await currentUser.linkWithCredential(googleCredential);
        Navigator.pushReplacementNamed(context, UserProfile.routeName);
      }
    } catch (e) {
      print(e);
    }
  }
}
