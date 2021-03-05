import 'package:evier/resources/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

import '../authentication/auth.dart';
import '../resources/custom_box_decoration.dart';
import '../resources/custom_gradient.dart';
import '../resources/strings.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String? email, password;

  bool isLoading = false;

  final _key = GlobalKey<FormState>();

  // ignore: non_constant_identifier_names
  Widget emailFormField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        hintText: Strings.emailHint,
        prefixIcon: Icon(Icons.mail_outline_rounded),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return Strings.emailError;
        }

        return null;
      },
      onSaved: (value) {
        email = value;
      },
    );
  }

  Widget passwordFormField() {
    return TextFormField(
      keyboardType: TextInputType.visiblePassword,
      obscureText: true,
      decoration: InputDecoration(
        hintText: Strings.passwordHint,
        prefixIcon: Icon(Icons.lock_outline_rounded),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return Strings.passwordError;
        }
        return null;
      },
      onSaved: (value) {
        password = value;
      },
    );
  }

  // ignore: non_constant_identifier_names
  Widget SignInWIthGoogleButton() {
    return Container(
      width: (kIsWeb &&
              MediaQuery.of(context).size.height <
                  MediaQuery.of(context).size.width)
          ? 400
          : null,
      child: RaisedButton(
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
                Strings.signInWithGoogle,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget CreateAccountButton() {
    return FlatButton(
      child: Text(
        Strings.createAccount,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      onPressed: () {
        Navigator.pushNamed(context, Routes.registerRoute);
      },
    );
  }

  // ignore: non_constant_identifier_names
  Widget LoginButton(BuildContext context) {
    return RaisedButton(
      onPressed: () {
        if (_key.currentState!.validate()) {
          _key.currentState!.save();
          setState(() {
            isLoading = true;
          });

          print(email! + password!);
          Auth().login(email!, password!).whenComplete(() {
            setState(() {
              isLoading = false;
            });
          });
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
            // Icon(Icons.login),
            // SizedBox(width: 20),
            Text(
              Strings.login,
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
      body: (kIsWeb &&
              MediaQuery.of(context).size.height <
                  MediaQuery.of(context).size.width)
          ? SingleChildScrollView(
              child: Row(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width / 2,
                    decoration: BoxDecoration(
                      color: Colors.blue[800], // gradient: CustomGradient(),
                    ),
                    child: Center(
                      child: Text(
                        Strings.title,
                        style: TextStyle(
                          fontSize: 100,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width / 2,
                    color: Colors.white,
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          Strings.login,
                          style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Form(
                          key: _key,
                          child: Container(
                            width: 400,
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  emailFormField(),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  passwordFormField(),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  isLoading
                                      ? CircularProgressIndicator()
                                      : LoginButton(context),
                                  SizedBox(
                                    height: 15,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Align(
                            alignment: Alignment.bottomCenter,
                            child: SignInWIthGoogleButton()),
                        SizedBox(
                          height: 10,
                        ),
                        CreateAccountButton(),
                      ],
                    ),
                  ),
                ],
              ),
            )
          : SingleChildScrollView(
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
                        SizedBox(
                          height: 20,
                        ),
                        CreateAccountButton(),
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
                    padding: EdgeInsets.all(1),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(height: 20),
                        Text(
                          Strings.title,
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    SizedBox(height: 15),
                                    Text(
                                      Strings.login,
                                      style: TextStyle(
                                        fontSize: 35,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(height: 15),
                                    emailFormField(),
                                    SizedBox(height: 20),
                                    passwordFormField(),
                                    SizedBox(height: 25),
                                    isLoading
                                        ? CircularProgressIndicator()
                                        : LoginButton(context),
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
