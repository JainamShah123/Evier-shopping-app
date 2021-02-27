import 'package:evier/resources/strings.dart';
import 'package:flutter/foundation.dart';

import '../authentication/auth.dart';
import '../resources/custom_box_decoration.dart';
import 'package:flutter/material.dart';
import '../resources/custom_gradient.dart';

enum Character { user, seller }

class RegistrationPage extends StatefulWidget {
  static String routeName = 'register';

  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final _key = GlobalKey<FormState>();
  Character character = Character.user;
  String email, password, gender, name, mobileNumber;
  bool isloading = false;

  Widget phoneNumber() {
    return TextFormField(
      keyboardType: TextInputType.phone,
      decoration: InputDecoration(
        hintText: "Phone Number",
        prefixIcon: Icon(Icons.phone),
      ),
      validator: (value) {
        if (value.isEmpty) {
          return "Please Enter the Phone Number";
        }
        return null;
      },
      onSaved: (value) {
        mobileNumber = value;
      },
    );
  }

  Widget userType() {
    return Row(
      children: [
        Radio(
          value: Character.user,
          groupValue: character,
          onChanged: (Character value) {
            setState(() {
              character = value;
              gender = "User";
            });
          },
        ),
        Text("User"),
        Radio(
          value: Character.seller,
          groupValue: character,
          onChanged: (Character value) {
            setState(() {
              character = value;
              gender = "Seller";
            });
          },
        ),
        Text("Seller"),
      ],
    );
  }

  Widget nameFormField() {
    return TextFormField(
      decoration: InputDecoration(
        hintText: "Full Name",
        prefixIcon: Icon(Icons.account_circle_outlined),
      ),
      validator: (value) {
        if (value.isEmpty) {
          return "Please Enter the Name";
        }
        return null;
      },
      onSaved: (value) {
        name = value;
      },
    );
  }

  Widget emailFormField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        hintText: Strings.emailHint,
        prefixIcon: Icon(Icons.mail_outline_rounded),
      ),
      validator: (value) {
        if (value.isEmpty) {
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
        if (value.isEmpty) {
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
  Widget signInWIthGoogleButton() {
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

  Widget goToLoginPageButton(BuildContext context) {
    return FlatButton(
      child: Text(
        Strings.goToLoginPage,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }

  void register(BuildContext context) {
    if (_key.currentState.validate()) {
      _key.currentState.save();
      setState(() {
        isloading = true;
      });
      Auth()
          .signup(
        email: email,
        password: password,
        gender: gender,
        name: name,
        phoneNumber: mobileNumber,
        context: context,
      )
          .whenComplete(() {
        setState(() {
          isloading = false;
        });
      });
    }
  }

  // ignore: non_constant_identifier_names

  // ignore: non_constant_identifier_names
  Widget registerButton(BuildContext context) {
    return RaisedButton(
      onPressed: () => register(context),
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
              Strings.register,
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
                      gradient: CustomGradient(),
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
                          Strings.register,
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
                                  nameFormField(),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  emailFormField(),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  passwordFormField(),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  userType(),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  phoneNumber(),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  isloading
                                      ? CircularProgressIndicator()
                                      : registerButton(context),
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
                            child: signInWIthGoogleButton()),
                        SizedBox(
                          height: 10,
                        ),
                        goToLoginPageButton(context),
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
                        signInWIthGoogleButton(),
                        goToLoginPageButton(context),
                      ],
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: 650,
                    decoration: BoxDecoration(
                      gradient: CustomGradient(),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(40),
                        bottomRight: Radius.circular(40),
                      ),
                    ),
                    padding: EdgeInsets.all(0.2),
                    child: SingleChildScrollView(
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
                                child: Column(
                                  children: [
                                    SizedBox(height: 15),
                                    Text(
                                      Strings.register,
                                      style: TextStyle(
                                        fontSize: 35,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(height: 15),
                                    nameFormField(),
                                    SizedBox(height: 20),
                                    emailFormField(),
                                    SizedBox(height: 15),
                                    passwordFormField(),
                                    SizedBox(height: 15),
                                    userType(),
                                    SizedBox(height: 15),
                                    phoneNumber(),
                                    SizedBox(height: 15),
                                    isloading
                                        ? CircularProgressIndicator()
                                        : registerButton(context),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
