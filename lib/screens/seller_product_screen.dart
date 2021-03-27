import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evier/resources/products.dart';
import 'package:evier/resources/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SellerProductScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var user = Provider.of<User?>(context);
    var uid = user!.uid;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Your Product"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.pushNamed(context, Routes.addProductRoute);
            },
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.only(left: 8, right: 8, top: 8),
        child: StreamBuilder(
            stream:
                FirebaseFirestore.instance.collection("products").snapshots(),
            builder: (ctx, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting)
                return Center(
                  child: CircularProgressIndicator(),
                );

              if (snapshot.hasError)
                return Center(
                  child: Text("Error"),
                );
              if (!snapshot.hasData) {
                return Center(
                  child: Text("currently there are no products available"),
                );
              }
              if (snapshot.hasData) {
                List<QueryDocumentSnapshot> productSnapshot =
                    snapshot.data!.docs;
                return GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: (kIsWeb &&
                              MediaQuery.of(context).size.height <
                                  MediaQuery.of(context).size.width)
                          ? 5
                          : 2,
                      childAspectRatio: 1.6 / 2,
                    ),
                    itemCount: productSnapshot.length,
                    itemBuilder: (ctx, index) {
                      if (productSnapshot[index]["seller"] == uid)
                        return Products(
                          title: productSnapshot[index]["name"],
                          url: productSnapshot[index]["imageUrl"],
                          price: productSnapshot[index]["price"],
                          description: productSnapshot[index]["description"],
                        );
                      return SizedBox.shrink();
                    });
              }
              return Container();
            }),
      ),
    );
  }
}
