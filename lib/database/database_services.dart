import 'package:cloud_firestore/cloud_firestore.dart';
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

  Future<UserData?> userData() {
    var userId = FirebaseAuth.instance.currentUser?.uid;
    var userDB = database.collection('user').doc(userId).get();
    return userDB.then((value) => UserData.fromFirestore(value));
  }

  Future updateDatabase({
    String? id,
    String? phoneNumber,
    String? name,
    String? address,
    String? type,
  }) async {
    var productDB = database.collection('products');
    var doc = productDB.doc(id);

    return await doc.update({
      'phonenumber': phoneNumber,
      'name': name,
      'address': address,
      'type': type,
    });
  }
}
