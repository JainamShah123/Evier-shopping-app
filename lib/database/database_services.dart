import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evier/database/favourites.dart';
import 'package:evier/database/orders.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'cart.dart';
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

  Stream<List<Cart?>?> cart() {
    var userId = FirebaseAuth.instance.currentUser?.uid;
    var cartdb =
        database.collection('user').doc(userId).collection('cart').snapshots();

    return cartdb
        .map((snap) => snap.docs.map((e) => Cart.fromFirestore(e)).toList());
  }

  Future<bool> favIsSet(String id) {
    var userId = FirebaseAuth.instance.currentUser?.uid;
    var favouritedb = database
        .collection('user')
        .doc(userId)
        .collection('favourites')
        .doc(id)
        .get();

    Future<bool> ans =
        favouritedb.then((value) => !value.exists ? false : true);

    return ans;
  }

  Future<bool> cartIsSet(String id) {
    var userId = FirebaseAuth.instance.currentUser?.uid;
    var favouritedb = database
        .collection('user')
        .doc(userId)
        .collection('cart')
        .doc(id)
        .get();

    Future<bool> ans =
        favouritedb.then((value) => !value.exists ? false : true);

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
    required String company,
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
      'company': company,
    });
  }

  Future setCart({
    required String id,
    required String productName,
    required String category,
    required String seller,
    required String price,
    required String description,
    required String imageUrl,
    required String company,
  }) {
    var userId = FirebaseAuth.instance.currentUser?.uid;
    var favouritedb =
        database.collection('user').doc(userId).collection('cart').doc(id);
    return favouritedb.set({
      'name': productName,
      'imageUrl': imageUrl,
      'description': description,
      'category': category,
      'seller': seller,
      'price': price,
      'company': company,
    });
  }

  Future submitOrders({
    required List<Cart?> cart,
    required String amount,
  }) {
    var userId = FirebaseAuth.instance.currentUser?.uid;
    var orderdb =
        database.collection('user').doc(userId).collection('orders').doc();

    var map = cart.map((e) => {
          "id": e!.id,
          "name": e.productName,
          "price": e.price,
          "company": e.company,
          "seller": e.seller,
          "description": e.description,
          "url": e.imageUrl,
        });

    return orderdb.set({
      'orderDetails': map.toList(),
      'amount': amount.toString(),
    });
  }

  Stream<List<Orders?>?> orders() {
    var userId = FirebaseAuth.instance.currentUser?.uid;
    var orderdb = database
        .collection('user')
        .doc(userId)
        .collection('orders')
        .snapshots();
    print(orderdb.isEmpty);
    return orderdb
        .map((snap) => snap.docs.map((e) => Orders.fromFirestore(e)).toList());
  }

  Future removeCart(String id) async {
    var userId = FirebaseAuth.instance.currentUser?.uid;
    var favouritedb =
        database.collection('user').doc(userId).collection('cart').doc(id);
    favouritedb.delete();
    notifyListeners();
  }

  Future saveUserData({
    required UserCredential userInfo,
    required String gender,
    required String phoneNumber,
    required String name,
  }) async {
    var userId = FirebaseAuth.instance.currentUser?.uid;
    await database.collection('user').doc(userId).set({
      'type': gender,
      'phonenumber': phoneNumber,
      'name': name,
    });
  }
}
