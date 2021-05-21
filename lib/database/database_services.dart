import 'package:evier/database/seller_product_data.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import '../database/favourites.dart';
import '../database/orders.dart';
import './cart.dart';
import './productsData.dart';
import './user_data.dart';

class DatabaseServices with ChangeNotifier {
  final FirebaseFirestore database = FirebaseFirestore.instance;

  Stream<List<ProductsData>?> products() {
    var productDB = database.collection('products');
    return productDB.snapshots().map((snap) => snap.docs
        .map((DocumentSnapshot<Map<String, dynamic>> doc) =>
            ProductsData.fromFirestore(doc))
        .where((element) => element.sold == false)
        .toList());
  }

  Stream<List<SellerProductData>?> sellerProducts() {
    var uid = FirebaseAuth.instance.currentUser?.uid;
    var productDB = database.collection('products');
    return productDB.snapshots().map((snap) => snap.docs
        .map((doc) => SellerProductData.fromFirestore(doc))
        .where((element) => element.seller == uid)
        .toList());
  }

  Stream<UserData?> userData() {
    var userid = FirebaseAuth.instance.currentUser!.uid;
    var userDB = database.collection('user').doc(userid).snapshots();

    return userDB.map((event) => UserData.fromFirestore(
          doc: event,
        ));
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
  }) async {
    var userId = FirebaseAuth.instance.currentUser?.uid;
    var favouritedb = database
        .collection('user')
        .doc(userId)
        .collection('favourites')
        .doc(id);
    favouritedb.set({
      'name': productName,
      'imageUrl': imageUrl,
      'description': description,
      'category': category,
      'seller': seller,
      'price': price,
      'company': company,
    });
    notifyListeners();
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
  }) async {
    var userId = FirebaseAuth.instance.currentUser?.uid;
    var favouritedb =
        database.collection('user').doc(userId).collection('cart').doc(id);
    favouritedb.set({
      'name': productName,
      'imageUrl': imageUrl,
      'description': description,
      'category': category,
      'seller': seller,
      'price': price,
      'company': company,
    });
    notifyListeners();
  }

  Future submitOrders({
    required List<Cart?> cart,
    required String amount,
  }) async {
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

    orderdb.set({
      'orderDetails': map.toList(),
      'amount': amount.toString(),
    });
    notifyListeners();
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
    required String gender,
    required String phoneNumber,
    required String name,
    required String address,
  }) async {
    var userId = FirebaseAuth.instance.currentUser?.uid;
    await database.collection('user').doc(userId).set({
      'type': gender,
      'phonenumber': phoneNumber,
      'name': name,
      'address': address
    });
    notifyListeners();
  }

  Future markProductAsSold({
    required String id,
    required String url,
    required String title,
    required String price,
    required String description,
    required String seller,
    required String company,
    required String category,
  }) async {
    var dataref = FirebaseFirestore.instance.collection("products").doc(id);
    dataref.set({
      "sold_out": true,
      'price': price,
      'name': title,
      'description': description,
      'imageUrl': url,
      'category': category,
      'seller': seller,
      'company': company
    });
    notifyListeners();
  }

  Future backToStock({
    required String id,
    required String url,
    required String title,
    required String price,
    required String description,
    required String seller,
    required String company,
    required String category,
  }) async {
    var dataref = FirebaseFirestore.instance.collection("products").doc(id);
    dataref.set({
      "sold_out": false,
      'price': price,
      'name': title,
      'description': description,
      'imageUrl': url,
      'category': category,
      'seller': seller,
      'company': company
    });
    notifyListeners();
  }

  Future addProduct({
    required String productPrice,
    required String nameOfProduct,
    required String productDescription,
    required String imageUrl,
    required String productCategory,
    required String sellerId,
    required String productCompany,
  }) async {
    CollectionReference productDatabase =
        FirebaseFirestore.instance.collection("products");
    await productDatabase.doc().set({
      'price': productPrice,
      'name': nameOfProduct,
      'description': productDescription,
      'imageUrl': imageUrl,
      'category': productCategory,
      'seller': sellerId,
      'company': productCompany,
      'sold_out': false,
    });
    notifyListeners();
  }

  Future updateProduct({
    required String productPrice,
    required String nameOfProduct,
    required String productDescription,
    required String imageUrl,
    required String productCategory,
    required String sellerId,
    required String productCompany,
    required String id,
    required bool sold,
  }) async {
    CollectionReference productDatabase =
        FirebaseFirestore.instance.collection("products");
    await productDatabase.doc(id).set({
      'price': productPrice,
      'name': nameOfProduct,
      'description': productDescription,
      'imageUrl': imageUrl,
      'category': productCategory,
      'seller': sellerId,
      'company': productCompany,
      'sold_out': sold,
    }).whenComplete(() => notifyListeners());
  }
}
