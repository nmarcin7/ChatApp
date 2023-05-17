import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class Auth extends ChangeNotifier {
  final _auth = FirebaseAuth.instance;
  User? user = FirebaseAuth.instance.currentUser;

  final postRef = FirebaseFirestore.instance.collection('posts').doc();

  void currentUserUid() {
    print(user!.uid);
  }

  void showSnackbar(
      context, String messageError, IconData icon, Color iconColor) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: Duration(milliseconds: 1500),
        content: Row(
          children: [
            Icon(
              icon,
              color: iconColor,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              messageError,
              style: TextStyle(),
            ),
          ],
        ),
      ),
    );
  }

  void clearFields(TextEditingController textEmailController,
      TextEditingController textPasswordController) {
    textEmailController.clear();
    textPasswordController.clear();
  }

  void registerUser(context, TextEditingController email,
      TextEditingController password, TextEditingController displayName) async {
    if (displayName.text.trim().isEmpty) {
      print('display name cannot be empty');
      showSnackbar(
          context, 'wprowadz nazwe uzytkownika', Icons.error, Colors.red);
      throw FirebaseAuthException(
        code: 'empty-display-name',
        message: 'Display name cannot be empty',
      );
    }

    try {
      EasyLoading.show(status: 'Loading');
      await _auth.createUserWithEmailAndPassword(
          email: email.text, password: password.text);

      await FirebaseAuth.instance.currentUser
          ?.updateDisplayName(displayName.text.trim());

      Navigator.pop(context);
      clearFields(email, password);

      showSnackbar(
          context, 'Account created', Icons.check_circle, Colors.green);
      EasyLoading.dismiss();
    } on FirebaseException catch (e) {
      if (e.code == 'email-already-in-use') {
        showSnackbar(context, "Email already in use", Icons.error, Colors.red);
      } else if (e.code == 'weak-password') {
        showSnackbar(context, 'Password is too weak', Icons.error, Colors.red);
      } else {
        showSnackbar(context, e.code, Icons.error, Colors.red);
      }
      EasyLoading.dismiss();
    }
  }

  void loggIn(TextEditingController email, TextEditingController password,
      context) async {
    try {
      EasyLoading.show(status: 'Loading');
      final loggedUser = await _auth.signInWithEmailAndPassword(
          email: email.text, password: password.text);
      user = await loggedUser.user;
      Navigator.pushNamed(context, 'chatPage');
      EasyLoading.dismiss();
      clearFields(email, password);
    } on FirebaseException catch (e) {
      if (e.code == 'invalid-email') {
        showSnackbar(context, 'Wrong email address', Icons.error, Colors.red);
        print(e);
      } else if (e.code == 'wrong-password') {
        showSnackbar(context, 'Wrong password', Icons.error, Colors.red);
      } else if (e.code == 'user-not-found') {
        showSnackbar(context, 'User not found', Icons.error, Colors.red);
      } else if (e.code == 'unknown') {
        showSnackbar(
            context, 'Fields cannot be empty!', Icons.error, Colors.red);
      }

      EasyLoading.dismiss();
    }
  }

  void loggedOut(context) async {
    await _auth.signOut();
    Navigator.pop(context);
  }
}
