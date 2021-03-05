import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/screens.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    User? _user = Provider.of<User?>(context);
    return (_user == null) ? Login() : HomeScreen();
  }
}
