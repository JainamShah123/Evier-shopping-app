import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserDetailEdit extends StatefulWidget {
  @override
  _UserDetailEditState createState() => _UserDetailEditState();
}

class _UserDetailEditState extends State<UserDetailEdit> {
  String? name, email, address, phoneNumber;

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<User?>(context);
    final userData =
        FirebaseFirestore.instance.collection('user').doc(user!.uid);
    final _key = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Edit your details"),
      ),
      body: FutureBuilder(
        future: userData.get(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text("Error"),
            );
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasData) {
            return Container(
              padding: EdgeInsets.all(16),
              child: Form(
                  key: _key,
                  child: ListView(
                    children: [
                      TextFormField(
                        onSaved: (value) {
                          name = value!;
                        },
                        initialValue: snapshot.data!.data()?['name'] ?? '',
                        decoration: InputDecoration(
                          hintText: "Name",
                        ),
                        validator: (value) {
                          if (value!.isEmpty) return "Please enter the Name";
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 16),
                        child: TextFormField(
                          onSaved: (value) {
                            email = value!;
                          },
                          decoration: InputDecoration(
                            hintText: "Email",
                          ),
                          keyboardType: TextInputType.emailAddress,
                          initialValue: user.email,
                          validator: (value) {
                            if (value!.isEmpty) return "Please enter the Email";
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
                            hintText: "Phone Number",
                          ),
                          initialValue:
                              snapshot.data!.data()?['phonenumber'] ?? '',
                          keyboardType: TextInputType.phone,
                          validator: (value) {
                            if (value!.isEmpty)
                              return "Please enter the phoneNumber";
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
                            hintText: "Address",
                          ),
                          maxLines: 5,
                          initialValue: snapshot.data!.data()?['address'] ?? '',
                          validator: (value) {
                            if (value!.isEmpty)
                              return "Please enter the Address";
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
                            if (!_key.currentState!.validate()) {
                              return;
                            }
                            _key.currentState!.save();
                            await userData.update({
                              'phonenumber': phoneNumber ??
                                  snapshot.data!.data()!['phonenumber'],
                              'name': name ?? snapshot.data!.data()!['name'],
                              'address':
                                  address ?? snapshot.data!.data()!['address'],
                              'type': snapshot.data!.data()!['type'],
                            });
                            var email1 = user.email;
                            await user.updateEmail(email ?? email1!);
                            Navigator.pop(context);
                          },
                        ),
                      ),
                    ],
                  )),
            );
          }
          return Container();
        },
      ),
    );
  }
}
