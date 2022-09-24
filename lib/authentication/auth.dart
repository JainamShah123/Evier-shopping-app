import 'dart:convert';

import 'package:evier/database/database_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class Auth with ChangeNotifier {
  FirebaseAuth _auth = FirebaseAuth.instance;

  User? user = FirebaseAuth.instance.currentUser;

  Future signup({
    required String email,
    required String password,
    required String gender,
    required String name,
    required String phoneNumber,
  }) async {
    print(jsonEncode({
      "name": name,
      "email": email,
      "type": gender,
      "phoneNumber": phoneNumber
    }));
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
            address: null,
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
    } catch (e) {
      print(e);
    }
    notifyListeners();
  }
}
