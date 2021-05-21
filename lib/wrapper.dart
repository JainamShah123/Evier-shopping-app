import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './screens/screens.dart' show Login, EvierBackDrop;

class Wrapper extends StatefulWidget {
  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  User? _user;

  @override
  Widget build(BuildContext context) {
    _user = Provider.of<User?>(context);
    return _user != null ? EvierBackDrop() : Login();
  }
}
