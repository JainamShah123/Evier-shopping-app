import 'package:cloud_firestore/cloud_firestore.dart';

class Orders {
  List<dynamic> cart;
  String amount;
  Orders({
    required this.cart,
    required this.amount,
  });

  factory Orders.fromFirestore(DocumentSnapshot doc) {
    Map? data = doc.data();

    return Orders(
      cart: data!['orderDetails'],
      amount: data['amount'],
    );
  }
}
