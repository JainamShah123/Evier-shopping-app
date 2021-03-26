import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evier/resources/routes.dart';
import 'package:evier/screens/seller_product_screen.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class EvierDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    CollectionReference query = FirebaseFirestore.instance.collection("user");
    User? user = Provider.of<User?>(context);

    print(user!.uid.toString());

    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            child: Text("Drawer"),
          ),
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
                // ? TextButton.icon(
                //     onPressed: () {
                //      Navigator.push(
                //         context,
                //         MaterialPageRoute(
                //           builder: (context) => AddProductScreen(),
                //         ),
                //       );
                //     },
                //     icon: Icon(Icons.add),
                //     label: Text(Strings.addProduct),
                //   )
                // : Container();
              }
              return Container();
            },
          ),
        ],
      ),
    );
  }
}
