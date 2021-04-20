import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evier/database/favourites.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'productsData.dart';
import 'user_data.dart';

class DatabaseServices with ChangeNotifier {
  final FirebaseFirestore database = FirebaseFirestore.instance;

  Stream<List<ProductsData>?> products() {
    var productDB = database.collection('products');
    return productDB.snapshots().map((snap) =>
        snap.docs.map((doc) => ProductsData.fromFirestore(doc)).toList());
  }

  Stream<UserData?> userData() {
    var userId = FirebaseAuth.instance.currentUser?.uid;
    var userDB = database.collection('user').doc(userId).snapshots();
    return userDB.map((event) => UserData.fromFirestore(event));
  }

  Stream<List<Favourites?>?> favourites() {
    var userId = FirebaseAuth.instance.currentUser?.uid;
    var favouritedb = database
        .collection('user')
        .doc(userId)
        .collection('favourites')
        .snapshots();

    return favouritedb.map(
        (snap) => snap.docs.map((e) => Favourites.fromFirestore(e)).toList());
  }

  bool favIsSet(String id) {
    var userId = FirebaseAuth.instance.currentUser?.uid;
    var favouritedb = database
        .collection('user')
        .doc(userId)
        .collection('favourites')
        .doc(id);
    var ans = favouritedb.id.isEmpty ? true : false;
    return ans;
  }

  Future removeFavorite(String id) async {
    var userId = FirebaseAuth.instance.currentUser?.uid;
    var favouritedb = database
        .collection('user')
        .doc(userId)
        .collection('favourites')
        .doc(id);
    favouritedb.delete();
    notifyListeners();
  }

  Future setFavourite({
    required String id,
    required String productName,
    required String category,
    required String seller,
    required String price,
    required String description,
    required String imageUrl,
  }) {
    var userId = FirebaseAuth.instance.currentUser?.uid;
    var favouritedb = database
        .collection('user')
        .doc(userId)
        .collection('favourites')
        .doc(id);
    return favouritedb.set({
      'name': productName,
      'imageUrl': imageUrl,
      'description': description,
      'category': category,
      'seller': seller,
      'price': price,
    });
  }
}
