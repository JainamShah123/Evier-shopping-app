import 'package:evier_login/resources/custom_box_decoration.dart';
import 'package:evier_login/resources/custom_gradient.dart';
import 'package:evier_login/screens/HomeScreen.dart';
import 'package:flutter/material.dart';

import '../resources/strings.dart';
import 'registration_page.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String email, password;

  bool isLoading = false;

  final _key = GlobalKey<FormState>();

  // ignore: non_constant_identifier_names
  Widget SignInWIthGoogleButton() {
    return RaisedButton(
      onPressed: () {},
      textColor: Colors.white,
      padding: const EdgeInsets.all(0.0),
      child: Container(
        height: 50,
        width: double.infinity,
        decoration: CustomBoxDecoration(),
        alignment: Alignment.center,
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(width: 20),
            Text(
              signInWithGoogle,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Widget LoginButton(BuildContext context) {
    return RaisedButton(
      onPressed: () {
        if (_key.currentState.validate()) {
          _key.currentState.save();
          print(email + password);
          Navigator.pushReplacementNamed(context, HomeScreen.routeName);
        }
      },
      textColor: Colors.white,
      padding: const EdgeInsets.all(0.0),
      child: Container(
        height: 45,
        width: 150,
        decoration: CustomBoxDecoration(),
        alignment: Alignment.center,
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.login),
            SizedBox(width: 20),
            Text(
              login,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              padding: EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SignInWIthGoogleButton(),
                  SizedBox(height: 20),
                  FlatButton(
                    child: Text(
                      createAccount,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 20),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, RegistrationPage.routeName);
                    },
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              height: 500,
              decoration: BoxDecoration(
                gradient: CustomGradient(),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(40),
                  bottomRight: Radius.circular(40),
                ),
              ),
              padding: EdgeInsets.all(0.2),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(height: 20),
                  Text(
                    "Evier",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 50,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(40),
                      ),
                    ),
                    color: Colors.white,
                    child: Padding(
                      padding: EdgeInsets.all(25),
                      child: Form(
                        key: _key,
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              SizedBox(height: 15),
                              Text(
                                "Login",
                                style: TextStyle(
                                  fontSize: 35,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 15),
                              TextFormField(
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                  hintText: "Email",
                                  prefixIcon: Icon(Icons.mail_outline_rounded),
                                ),
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return "Please enter the email";
                                  }

                                  return null;
                                },
                                onSaved: (value) {
                                  email = value;
                                },
                              ),
                              SizedBox(height: 20),
                              TextFormField(
                                keyboardType: TextInputType.visiblePassword,
                                obscureText: true,
                                decoration: InputDecoration(
                                  hintText: "Password",
                                  prefixIcon: Icon(Icons.lock_outline_rounded),
                                ),
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return "Please enter the password";
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  password = value;
                                },
                              ),
                              SizedBox(height: 25),
                              LoginButton(context),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
