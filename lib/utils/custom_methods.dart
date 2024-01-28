import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';

import 'auth_container.dart';

popUpMessage(BuildContext context, TextEditingController controller) =>
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          "Reset Password",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "Email will be sent with a \nlink please follow that to \nreset password.",
            ),
            const SizedBox(
              height: 35,
            ),
            CustomTextfield(text: 'email', controller: controller)
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text(
              "cancel",
            ),
          ),
          TextButton(
            onPressed: () {},
            child: const Text(
              "send link",
            ),
          )
        ],
      ),
    );

showMessage(BuildContext context, String message) =>
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
        ),
      ),
    );

void signInFacebook() async {
// Create an instance of FacebookLogin
  final fb = FacebookLogin();

// Log in
  final res = await fb.expressLogin();

  if (res.status == FacebookLoginStatus.success) {
    final FacebookAccessToken? accessToken = res.accessToken;
   // print('Access token: ${accessToken?.token}');
  }
}

Future<UserCredential> signInGoogle() async {
  // Create a new provider
  GoogleAuthProvider googleProvider = GoogleAuthProvider();

  googleProvider.addScope('https://www.googleapis.com/auth/contacts.readonly');
  googleProvider.setCustomParameters({'login_hint': 'user@example.com'});

  // Once signed in, return the UserCredential
  return await FirebaseAuth.instance.signInWithPopup(googleProvider);
}
