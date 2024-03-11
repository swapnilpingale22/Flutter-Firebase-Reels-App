import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fun_unlimited/models/user.dart' as model;
import 'package:fun_unlimited/screens/auth/login_screen.dart';
import 'package:fun_unlimited/utils/utils.dart';

class AuthServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  //sign up user

  Future<String> signUpUser({
    required String name,
    required String email,
    required String password,
    required int mobileNumber,
  }) async {
    String res = "Please fill all the fields.";
    try {
      if (email.isNotEmpty && password.isNotEmpty && name.isNotEmpty) {
        //register user
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        //add user to our database
        model.User user = model.User(
          name: name,
          email: email,
          mobileNumber: mobileNumber,
          uid: cred.user!.uid,
        );

        await _firestore.collection('users').doc(cred.user!.uid).set(
              user.toJson(),
            );
        res = "Success";
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        res = 'The account already exists for that email.';
      } else {
        res = e.code.toString();
      }
    }
    return res;
  }

//logging users in

  Future<String> logInUser({
    required String email,
    required String password,
  }) async {
    String res = "Please fill all the required fields.";

    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        res = "Success";
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        res = 'No user found for this email.';
      } else if (e.code == 'wrong-password') {
        res = 'Wrong password provided for this user.';
      } else {
        res = e.code.toString();
      }
    }
    return res;
  }

  //signing users out

  Future<void> signOut(BuildContext context) async {
    await _auth.signOut().then((_) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        ),
      );
      showSnackBar("You're logged out", context);
    }).onError(
      (error, stackTrace) => showSnackBar(error.toString(), context),
    );
  }

  //delete user account
  Future<void> deleteAccount(BuildContext context) async {
    await _firestore
        .collection('users')
        .doc(_auth.currentUser!.uid)
        .delete()
        .then(
      (_) async {
        await _auth.currentUser!.delete();
      },
    ).then(
      (_) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const LoginScreen(),
          ),
        );
        showSnackBar("Account deleted permanently", context);
      },
    ).onError(
      (error, stackTrace) => showSnackBar(error.toString(), context),
    );
  }
}
