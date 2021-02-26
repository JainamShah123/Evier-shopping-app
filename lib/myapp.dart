import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './resources/strings.dart';
import './screens/screens.dart';
import './resources/themes.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    User _user = Provider.of<User>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: Strings.appTitle,
      theme: theme,
      home: (_user == null) ? Login() : HomeScreen(),
      routes: {
        RegistrationPage.routeName: (context) => RegistrationPage(),
      },
    );
  }
}
