import 'package:evier/authentication/auth.dart';
import 'package:evier/resources/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../colors.dart';
import '../theme.dart';
import '../letter_spacing.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String? email, password;

  bool isLoading = false;

  final _key = GlobalKey<FormState>();

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
          textInputAction: TextInputAction.send,
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
              color: shrineBrown900,
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

  Widget createAccountButton() {
    return TextButton(
      child: Text(
        AppLocalizations.of(context)!.createAccount,
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.bodyText1!.copyWith(
              fontSize: 20,
            ),
      ),
      onPressed: () {
        Navigator.pushNamed(context, Routes.registerRoute);
      },
    );
  }

  Widget loginButton(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        elevation: 8,
        shape: const BeveledRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(7)),
        ),
      ),
      onPressed: () async {
        if (_key.currentState!.validate()) {
          _key.currentState!.save();
          setState(() {
            isLoading = true;
          });
          try {
            await Auth()
                .login(
                  email,
                  password,
                )
                .whenComplete(
                  () => setState(() {
                    isLoading = false;
                  }),
                );
          } on FirebaseAuthException catch (e) {
            if (e.code == 'user-not-found') {
              print('No user found for that email.');
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text("No user found for that email."),
              ));
            } else if (e.code == 'wrong-password') {
              print('Wrong password provided for that user.');
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text("Wrong password provided for that user."),
              ));
            }
          } catch (e) {
            ScaffoldMessenger.of(context).showSnackBar(
              new SnackBar(
                content: Text(
                  e.toString(),
                ),
              ),
            );
          }
        }
      },
      child: Container(
        height: 50,
        width: 100,
        alignment: Alignment.center,
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              AppLocalizations.of(context)!.login,
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
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(16),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          alignment: Alignment.center,
          child: SingleChildScrollView(
            child: Form(
              key: _key,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    AppLocalizations.of(context)!.title,
                    style: Theme.of(context)
                        .textTheme
                        .headline3!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  emailFormField(),
                  SizedBox(
                    height: 12,
                  ),
                  passwordFormField(),
                  SizedBox(
                    height: 10,
                  ),
                  isLoading
                      ? CircularProgressIndicator(
                          color: shrineBrown600,
                        )
                      : loginButton(context),
                  SizedBox(
                    height: 10,
                  ),
                  createAccountButton(),
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
