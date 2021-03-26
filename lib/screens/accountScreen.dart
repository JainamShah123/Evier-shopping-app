import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evier/authentication/auth.dart';
import 'package:evier/resources/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class AccountScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var user = Provider.of<User?>(context);

    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection("user")
          .doc(user!.uid)
          .snapshots(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError)
          return Center(
            child: Text("Error"),
          );

        if (snapshot.hasData) {
          var data = snapshot.data!.data();
          return ListView(
            padding: EdgeInsets.all(16),
            children: [
              Center(
                child: FaIcon(
                  FontAwesomeIcons.solidUserCircle,
                  color: Theme.of(context).primaryColor,
                  size: 70,
                ),
              ),
              ListTile(
                title: Center(
                    child: Text(
                  data!['name'] ?? '',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                )),
                subtitle: Center(child: Text(user.email ?? '')),
              ),
              Divider(
                thickness: 1,
              ),
              ListTile(
                leading: FaIcon(FontAwesomeIcons.phoneAlt),
                title: Text(
                  data['phonenumber'] ?? "Please enter the phone number",
                ),
              ),
              ListTile(
                leading: FaIcon(FontAwesomeIcons.addressCard),
                title: Text(
                  data['address'] ?? "Please enter the address",
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Column(
                  children: [
                    ElevatedButton(
                      child: Text("Edit"),
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          Routes.userDetailEdit,
                        );
                      },
                    ),
                    TextButton(
                      onPressed: () {
                        Auth().logout();
                      },
                      child: Text('Logout'),
                    ),
                  ],
                ),
              ),
            ],
          );
        }

        return Container();
      },
    );
  }
}
