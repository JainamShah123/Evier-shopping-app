import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evier/database/favourites.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'productsData.dart';
import 'user_data.dart';

class DatabaseServices {
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

  Future setFavourite(String id) {
    var userId = FirebaseAuth.instance.currentUser?.uid;
    var favouritedb =
        database.collection('user').doc(userId).collection('favourites').doc();
    return favouritedb.set({
      'id': id,
    });
  }
}
