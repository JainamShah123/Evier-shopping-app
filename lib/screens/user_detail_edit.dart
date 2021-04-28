import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:provider/provider.dart';

import 'package:firebase_auth/firebase_auth.dart';

import '../database/database.dart' show UserData;

class UserDetailEdit extends StatefulWidget {
  @override
  _UserDetailEditState createState() => _UserDetailEditState();
}

class _UserDetailEditState extends State<UserDetailEdit> {
  var userdb = FirebaseFirestore.instance.collection('user');
  String? name, email, address, phoneNumber;

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<User?>(context);
    var userData = Provider.of<UserData?>(context);

    final _key = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Edit your details"),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Form(
            key: _key,
            child: ListView(
              children: [
                TextFormField(
                  onSaved: (value) {
                    name = value!;
                  },
                  initialValue: userData!.name ?? '',
                  decoration: InputDecoration(
                    hintText: AppLocalizations.of(context)!.accountNameHint,
                  ),
                  validator: (value) {
                    if (value!.isEmpty)
                      return AppLocalizations.of(context)!.accountNameError;
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: TextFormField(
                    onSaved: (value) {
                      email = value!;
                    },
                    decoration: InputDecoration(
                      hintText: AppLocalizations.of(context)!.emailHint,
                    ),
                    keyboardType: TextInputType.emailAddress,
                    initialValue: user!.email,
                    validator: (value) {
                      if (value!.isEmpty)
                        return AppLocalizations.of(context)!.emailHint;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: TextFormField(
                    onSaved: (value) {
                      phoneNumber = value!;
                    },
                    decoration: InputDecoration(
                      hintText: AppLocalizations.of(context)!.phoneNumberHint,
                    ),
                    initialValue: userData.phoneNumber ?? '',
                    keyboardType: TextInputType.phone,
                    validator: (value) {
                      if (value!.isEmpty)
                        return AppLocalizations.of(context)!.phoneNumberError;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: TextFormField(
                    onSaved: (value) {
                      address = value!;
                    },
                    decoration: InputDecoration(
                      hintText: AppLocalizations.of(context)!.addressHint,
                    ),
                    maxLines: 5,
                    initialValue: userData.address ?? '',
                    validator: (value) {
                      if (value!.isEmpty)
                        return AppLocalizations.of(context)!.addressError;
                    },
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(top: 16),
                  child: ElevatedButton(
                    child: Container(
                      alignment: Alignment.center,
                      width: 70,
                      child: Text(
                        "Submit",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    onPressed: () async {
                      if (_key.currentState!.validate()) {
                        _key.currentState!.save();
                        await userdb.doc(user.uid).update({
                          'address': address ?? userData.address!,
                          'type': userData.type,
                          'phonenumber': phoneNumber ?? userData.phoneNumber!,
                          'name': name ?? userData.name!,
                        }).catchError((onError) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                onError.toString(),
                              ),
                            ),
                          );
                        });

                        await user.updateEmail(email ?? user.email!);
                        Navigator.pop(context);
                      }
                    },
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
