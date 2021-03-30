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

  Stream<UserData?> userData() {
    var userId = FirebaseAuth.instance.currentUser?.uid;
    var userDB = database.collection('user').doc(userId).snapshots();
    return userDB.map((event) => UserData.fromFirestore(event));
  }

  // Future updateDatabase({
  //   String? id,
  //   String? phoneNumber,
  //   String? name,
  //   String? address,
  //   String? type,
  // }) async {
  //   var productDB = database.collection('user').doc(id);

  //   return await productDB.set({
  //     'phonenumber': phoneNumber!,
  //     'name': name!,
  //     'address': address!,
  //     'type': type!,
  //   });
  // }
}
