import 'package:evier_login/screens/HomeScreen.dart';
import 'package:flutter/material.dart';
import 'screens/registration_page.dart';
import 'screens/login.dart';

import 'resources/strings.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: appTitle,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
          ),
        ),
        buttonTheme: ButtonThemeData(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Login(),
      routes: {
        RegistrationPage.routeName: (context) => RegistrationPage(),
        HomeScreen.routeName: (context) => HomeScreen(),
      },
    );
  }
}
