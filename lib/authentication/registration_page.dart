import 'package:evier/screens/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../authentication/auth.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';

import '../colors.dart';
import '../letter_spacing.dart';
import '../theme.dart';

enum Character { user, seller }

class RegistrationPage extends StatefulWidget {
  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  late Auth auth;
  final _key = GlobalKey<FormState>();
  Character? character = Character.user;
  String? email, password, gender = "User", name, mobileNumber;

  bool isloading = false;

  Widget nameFormField() {
    final colorScheme = Theme.of(context).colorScheme;

    return _PrimaryColorOverride(
      color: shrineBrown900,
      child: TextFormField(
        textInputAction: TextInputAction.next,
        cursorColor: colorScheme.onSurface,
        keyboardType: TextInputType.name,
        decoration: InputDecoration(
          hintText: AppLocalizations.of(context)!.accountNameHint,
          prefixIcon: Icon(
            FontAwesomeIcons.user,
            color: shrineBrown600,
          ),
          hintStyle: TextStyle(
            letterSpacing: letterSpacingOrNone(mediumLetterSpacing),
            color: shrineBrown900,
          ),
        ),
        validator: (value) {
          if (value!.isEmpty) {
            return AppLocalizations.of(context)!.accountNameError;
          }
          return null;
        },
        onSaved: (value) {
          name = value;
        },
      ),
    );
  }

  Widget emailFormField() {
    final colorScheme = Theme.of(context).colorScheme;

    return _PrimaryColorOverride(
      color: shrineBrown900,
      child: Container(
        child: TextFormField(
          textInputAction: TextInputAction.next,
          cursorColor: colorScheme.onSurface,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            hintText: AppLocalizations.of(context)!.emailHint,
            prefixIcon: Icon(
              FontAwesomeIcons.envelope,
              color: shrineBrown600,
            ),
            hintStyle: TextStyle(
              letterSpacing: letterSpacingOrNone(mediumLetterSpacing),
              color: shrineBrown900,
            ),
          ),
          validator: (value) {
            if (value!.isEmpty) {
              return AppLocalizations.of(context)!.emailError;
            }
            return null;
          },
          onSaved: (value) {
            email = value;
          },
        ),
      ),
    );
  }

  Widget passwordFormField() {
    final colorScheme = Theme.of(context).colorScheme;

    return _PrimaryColorOverride(
      color: shrineBrown900,
      child: Container(
        child: TextFormField(
          textInputAction: TextInputAction.next,
          cursorColor: colorScheme.onSurface,
          keyboardType: TextInputType.visiblePassword,
          obscureText: true,
          obscuringCharacter: "*",
          decoration: InputDecoration(
            hintText: AppLocalizations.of(context)!.passwordHint,
            prefixIcon: Icon(
              FontAwesomeIcons.key,
              color: shrineBrown600,
            ),
            hintStyle: TextStyle(
              letterSpacing: letterSpacingOrNone(mediumLetterSpacing),
              color: shrineBrown600,
            ),
          ),
          validator: (value) {
            if (value!.isEmpty) {
              return AppLocalizations.of(context)!.passwordError;
            }
            return null;
          },
          onSaved: (value) {
            password = value;
          },
        ),
      ),
    );
  }

  Widget phoneNumber() {
    final colorScheme = Theme.of(context).colorScheme;

    return _PrimaryColorOverride(
      color: shrineBrown900,
      child: Container(
        child: TextFormField(
          textInputAction: TextInputAction.done,
          cursorColor: colorScheme.onSurface,
          keyboardType: TextInputType.phone,
          decoration: InputDecoration(
            prefix: Text("+91"),
            hintText: AppLocalizations.of(context)!.phoneNumberHint,
            prefixIcon: Icon(
              FontAwesomeIcons.phoneAlt,
              color: shrineBrown600,
            ),
            hintStyle: TextStyle(
              letterSpacing: letterSpacingOrNone(mediumLetterSpacing),
              color: shrineBrown600,
            ),
          ),
          validator: (value) {
            if (value!.isEmpty) {
              return AppLocalizations.of(context)!.phoneNumberHint;
            }

            return null;
          },
          onSaved: (value) {
            mobileNumber = value;
          },
        ),
      ),
    );
  }

  Widget userType() {
    return Row(
      children: [
        Radio(
          activeColor: shrineBrown600,
          value: Character.user,
          groupValue: character,
          onChanged: (Character? value) {
            setState(() {
              character = value;
              gender = "User";
            });
          },
        ),
        Text("User"),
        Radio(
          activeColor: shrineBrown600,
          value: Character.seller,
          groupValue: character,
          onChanged: (Character? value) {
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

  Widget goToLoginPageButton(BuildContext context) {
    return _PrimaryColorOverride(
      color: shrineBrown900,
      child: TextButton(
        child: Text(
          AppLocalizations.of(context)!.goToLoginPage,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20,
            color: shrineBrown900,
          ),
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }

  void register(BuildContext context) async {
    if (_key.currentState!.validate()) {
      _key.currentState!.save();
      print(
        mobileNumber! + name! + email! + gender! + password!,
      );
      setState(() {
        isloading = true;
      });
      try {
        await auth.signup(
          email: email!,
          password: password!,
          gender: gender!,
          name: name!,
          phoneNumber: mobileNumber!,
        );

        setState(() {
          isloading = false;
        });
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("The password is too weak"),
          ));
        } else if (e.code == 'email-already-in-use') {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("The email is already in use"),
          ));
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(e.toString()),
        ));
      } finally {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => HomeScreen(),
          ),
        );
      }
    }
  }

  Widget registerButton(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        elevation: 8,
        shape: const BeveledRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(7)),
        ),
      ),
      onPressed: () => register(context),
      child: Container(
        height: 50,
        width: 120,
        alignment: Alignment.center,
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              AppLocalizations.of(context)!.register,
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
    auth = Provider.of<Auth>(context);
    return Scaffold(
      body: SafeArea(
        child: Container(
          alignment: Alignment.center,
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Form(
              key: _key,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    AppLocalizations.of(context)!.register,
                    style: Theme.of(context)
                        .textTheme
                        .headline4!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  nameFormField(),
                  SizedBox(
                    height: 15,
                  ),
                  emailFormField(),
                  SizedBox(
                    height: 15,
                  ),
                  passwordFormField(),
                  SizedBox(
                    height: 15,
                  ),
                  userType(),
                  SizedBox(
                    height: 15,
                  ),
                  phoneNumber(),
                  SizedBox(
                    height: 15,
                  ),
                  isloading
                      ? CircularProgressIndicator()
                      : registerButton(context),
                  SizedBox(
                    height: 10,
                  ),
                  goToLoginPageButton(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _PrimaryColorOverride extends StatelessWidget {
  const _PrimaryColorOverride({
    Key? key,
    required this.color,
    required this.child,
  }) : super(key: key);

  final Color color;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Theme(
      child: child,
      data: Theme.of(context).copyWith(primaryColor: color),
    );
  }
}
