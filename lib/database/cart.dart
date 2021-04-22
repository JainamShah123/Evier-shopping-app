import 'package:cloud_firestore/cloud_firestore.dart';

class Cart {
  String? id;
  String? productName;
  String? price;
  String? seller;
  String? category;
  String? description;
  String? imageUrl;
  String? company;

  Cart({
    required this.id,
    required this.productName,
    required this.price,
    required this.seller,
    required this.category,
    required this.description,
    required this.imageUrl,
    required this.company,
  });
  factory Cart.fromFirestore(DocumentSnapshot doc) {
    Map? data = doc.data();
    return Cart(
      id: doc.id,
      productName: data?['name'],
      price: data?['price'],
      seller: data?['seller'],
      category: data?['category'],
      description: data?['description'],
      imageUrl: data?['imageUrl'],
      company: data?['company'],
    );
  }
}
