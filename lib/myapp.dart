import 'package:evier/wrapper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './resources/strings.dart';
import './screens/screens.dart';
import './resources/themes.dart';
import 'resources/routes.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: Strings.appTitle,
      theme: theme, // Theme is in seperate file {Ctrl + click}
      // Verifying user form application cache
      home: Wrapper(),
      routes: {
        Routes.registerRoute: (context) => RegistrationPage(),
        Routes.accountRoute: (context) => AccountScreen(),
      },
    );
  }
}
