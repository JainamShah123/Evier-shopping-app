import 'package:evier/authentication/auth.dart';
import 'package:evier/resources/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../resources/custom_box_decoration.dart';
import '../resources/custom_gradient.dart';
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

    return PrimaryColorOverride(
      color: shrineBrown900,
      child: Container(
        child: TextFormField(
          textInputAction: TextInputAction.next,
          cursorColor: colorScheme.onSurface,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            focusColor: shrineBrown900,
            labelText: AppLocalizations.of(context)!.emailHint,
            prefixIcon: Icon(Icons.mail_outline_rounded),
            labelStyle: TextStyle(
              letterSpacing: letterSpacingOrNone(mediumLetterSpacing),
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
    return TextFormField(
      keyboardType: TextInputType.visiblePassword,
      obscureText: true,
      decoration: InputDecoration(
        hintText: AppLocalizations.of(context)!.passwordHint,
        prefixIcon: Icon(Icons.lock_outline_rounded),
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
    );
  }

  Widget createAccountButton() {
    return TextButton(
      child: Text(
        AppLocalizations.of(context)!.createAccount,
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.bodyText1!.copyWith(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
      ),
      onPressed: () {
        Navigator.pushNamed(context, Routes.registerRoute);
      },
    );
  }

  Widget loginButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        if (_key.currentState!.validate()) {
          _key.currentState!.save();
          setState(() {
            isLoading = true;
          });

          await Auth()
              .login(email, password, context)
              .whenComplete(() => setState(() {
                    isLoading = false;
                  }));
        }
      },
      child: Container(
        height: 45,
        width: 150,
        decoration: CustomBoxDecoration(),
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
                      color: Colors.blue[800],
                    ),
                    child: Center(
                      child: Text(
                        AppLocalizations.of(context)!.title,
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
                          AppLocalizations.of(context)!.login,
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
                                      : loginButton(context),
                                  SizedBox(
                                    height: 15,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        createAccountButton(),
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
                        SizedBox(
                          height: 20,
                        ),
                        Center(child: createAccountButton()),
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
                          AppLocalizations.of(context)!.title,
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
                                      AppLocalizations.of(context)!.login,
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
                                        : loginButton(context),
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

class PrimaryColorOverride extends StatelessWidget {
  const PrimaryColorOverride({
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
