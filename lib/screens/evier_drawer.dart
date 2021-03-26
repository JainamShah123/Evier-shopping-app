import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evier/resources/routes.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class EvierDrawer extends StatefulWidget {
  @override
  _EvierDrawerState createState() => _EvierDrawerState();
}

class _EvierDrawerState extends State<EvierDrawer> {
  @override
  Widget build(BuildContext context) {
    CollectionReference query = FirebaseFirestore.instance.collection("user");
    User? user = Provider.of<User?>(context);

    print(user!.uid.toString());

    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Column(
                children: [
                  Center(
                    child: FaIcon(
                      FontAwesomeIcons.solidUserCircle,
                      color: Colors.white,
                      size: 70,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 15),
                    child: Center(
                      child: FutureBuilder(
                        future: FirebaseFirestore.instance
                            .collection('user')
                            .doc(user.uid)
                            .get(),
                        builder: (BuildContext context,
                            AsyncSnapshot<DocumentSnapshot> snapshot) {
                          if (snapshot.hasError) return Text("Error");
                          if (snapshot.hasData)
                            return Text(
                              snapshot.data!.data()!['name'] ?? "name not set",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            );
                          return Container();
                        },
                      ),
                    ),
                  ),
                ],
              )),
          FutureBuilder(
            future: query.doc(user.uid).get(),
            builder: (ctx, AsyncSnapshot<DocumentSnapshot> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }
              if (snapshot.connectionState == ConnectionState.done) {
                var data = snapshot.data!.data();
                return data!['type'] == 'Seller'
                    ? ListTile(
                        onTap: () => Navigator.pushNamed(
                            context, Routes.sellerProductRoute),
                        leading: FaIcon(FontAwesomeIcons.objectGroup),
                        title: Text("Your Products"),
                      )
                    : Container();
              }
              return Container();
            },
          ),
        ],
      ),
    );
  }
}
