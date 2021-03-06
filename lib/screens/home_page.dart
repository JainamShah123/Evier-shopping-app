import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evier/resources/products.dart';
import 'package:evier/screens/product_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import 'cart_screen.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 8, right: 8, top: 8),
      child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection("products").snapshots(),
          // ignore: missing_return
          builder: (ctx, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting)
              return Center(
                child: CircularProgressIndicator(),
              );

            if (snapshot.hasError)
              return Center(
                child: Text("Error"),
              );

            if (snapshot.hasData) {
              List<QueryDocumentSnapshot> productSnapshot = snapshot.data!.docs;
              return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: (kIsWeb &&
                          MediaQuery.of(context).size.height <
                              MediaQuery.of(context).size.width)
                      ? 5
                      : 2,
                  // crossAxisSpacing: 5,
                  childAspectRatio: 1.6 / 2,
                ),
                itemCount: productSnapshot.length,
                itemBuilder: (ctx, index) => Products(
                  title: productSnapshot[index]["name"],
                  url: productSnapshot[index]["imageUrl"],
                  price: productSnapshot[index]["price"],
                  description: productSnapshot[index]["description"],
                ),
              );
            }
            return Container();
          }),
    );
  }
}
