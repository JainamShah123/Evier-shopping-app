import '../screens/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Auth {
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore _storage = FirebaseFirestore.instance;

  Future signup({
    String email,
    String password,
    String gender,
    String phoneNumber,
    String name,
    BuildContext context,
  }) async {
    UserCredential userCredential;
    try {
      userCredential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print("The password is too weak");
      } else if (e.code == 'email-already-in-use') {
        print("The email is already in use");
      }
    } catch (e) {
      print(e);
    } finally {
      _storage.collection('user').doc(userCredential.user.uid).set({
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
    String email,
    String password,
  ) async {
    UserCredential userCredential;
    try {
      userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    } catch (e) {
      print(e);
    }
  }

  Future logout() async {
    await _auth.signOut();
  }
}
