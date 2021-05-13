import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evier/database/database_services.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/foundation.dart';

class Auth with ChangeNotifier {
  FirebaseFirestore _storage = FirebaseFirestore.instance;

  FirebaseAuth _auth = FirebaseAuth.instance;

  User? user = FirebaseAuth.instance.currentUser;

  Future signup({
    required String email,
    required String password,
    required String gender,
    required String name,
    required String phoneNumber,
  }) async {
    await _auth
        .createUserWithEmailAndPassword(
          email: email,
          password: password,
        )
        .then(
          (value) async => await DatabaseServices().saveUserData(
            gender: gender,
            phoneNumber: phoneNumber,
            name: name,
            address: '',
          ),
        );
  }

  Future login(
    String? email,
    String? password,
  ) async {
    await _auth.signInWithEmailAndPassword(email: email!, password: password!);
  }

  Future logout() async {
    try {
      await _auth.signOut();
      await _storage.clearPersistence();
    } catch (e) {
      print(e);
    }
    notifyListeners();
  }
}
