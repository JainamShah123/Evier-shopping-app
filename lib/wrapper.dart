import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:firebase_auth/firebase_auth.dart';

import './screens/screens.dart' show Login;
import './evier_backdrop.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    User? _user = Provider.of<User?>(context);
    return (_user == null) ? Login() : EvierBackDrop();
  }
}
