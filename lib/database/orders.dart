import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evier/database/cart.dart';

class Orders {
  List<Cart?> cart;
  double amount;
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
