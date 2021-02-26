import 'package:evier/resources/strings.dart';

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
  Widget SignUpWIthGoogleButton() {
    return RaisedButton(
      onPressed: () {},
      textColor: Colors.white,
      padding: const EdgeInsets.all(0.0),
      child: Container(
        height: 50,
        width: double.infinity,
        decoration: const CustomBoxDecoration(),
        alignment: Alignment.center,
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              Strings.signInWithGoogle,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Widget RegisterButton() {
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
                  SignUpWIthGoogleButton(),
                  FlatButton(
                    child: Text(
                      Strings.goToLoginPage,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 20),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
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
                              TextFormField(
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                  hintText: "Full Name",
                                  prefixIcon:
                                      Icon(Icons.account_circle_outlined),
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
                              ),
                              SizedBox(height: 20),
                              TextFormField(
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                  hintText: "Email",
                                  prefixIcon: Icon(Icons.mail_outline_rounded),
                                ),
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return "Please Enter the Email";
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  email = value;
                                },
                              ),
                              SizedBox(height: 15),
                              TextFormField(
                                keyboardType: TextInputType.visiblePassword,
                                obscureText: true,
                                decoration: InputDecoration(
                                  hintText: "Password",
                                  prefixIcon: Icon(Icons.lock_outline_rounded),
                                ),
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return "Please Enter the Password";
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  password = value;
                                },
                              ),
                              SizedBox(height: 15),
                              Row(
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
                              ),
                              SizedBox(height: 15),
                              TextFormField(
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
                              ),
                              SizedBox(height: 15),
                              isloading
                                  ? CircularProgressIndicator()
                                  : RegisterButton(),
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
