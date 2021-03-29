import 'package:cloud_firestore/cloud_firestore.dart';
import 'productsData.dart';

class DatabaseServices {
  final FirebaseFirestore database = FirebaseFirestore.instance;
  Stream<List<ProductsData>?> products() {
    var dataInstance = database.collection('products');
    return dataInstance.snapshots().map((snap) =>
        snap.docs.map((doc) => ProductsData.fromFirestore(doc)).toList());
  }
}
