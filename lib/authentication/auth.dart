import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../screens/home_screen.dart';

class Auth with ChangeNotifier {
  FirebaseFirestore _storage = FirebaseFirestore.instance;

  FirebaseAuth _auth = FirebaseAuth.instance;

  User? user = FirebaseAuth.instance.currentUser;

  Future signup({
    required String email,
    required String password,
    String? gender,
    String? phoneNumber,
    String? name,
    required BuildContext context,
  }) async {
    late UserCredential userCredential;

    try {
      userCredential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print("The password is too weak");
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("The password is too weak"),
        ));
      } else if (e.code == 'email-already-in-use') {
        print("The email is already in use");
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("The email is already in use"),
        ));
      }
    } finally {
      _storage.collection("user").doc(userCredential.user!.uid).set({
        'type': gender,
        'phonenumber': phoneNumber,
        'name': name,
      });
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    }
  }

  Future login(
    String? email,
    String? password,
    BuildContext context,
  ) async {
    late UserCredential userCredential;

    try {
      userCredential = await _auth.signInWithEmailAndPassword(
          email: email!, password: password!);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("No user found for that email."),
        ));
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Wrong password provided for that user."),
        ));
      }
    } catch (e) {
      print(e);
    }
  }

  Future logout() async {
    await _auth.signOut();
    user = null;
    notifyListeners();
  }
}
