import 'package:flutter/material.dart';
import './wrapper.dart';
import 'resources/strings.dart';
import 'screens/screens.dart';
import './resources/themes.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: appTitle,
      theme: theme,
      home: Wrapper(),
      routes: {
        RegistrationPage.routeName: (context) => RegistrationPage(),
      },
    );
  }
}
