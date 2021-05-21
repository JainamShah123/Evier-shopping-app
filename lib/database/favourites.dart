import 'package:cloud_firestore/cloud_firestore.dart';

class Favourites {
  String? id;
  String? productName;
  String? price;
  String? seller;
  String? category;
  String? description;
  String? imageUrl;
  String? company;

  Favourites({
    required this.id,
    required this.productName,
    required this.price,
    required this.seller,
    required this.category,
    required this.description,
    required this.imageUrl,
    required this.company,
  });
  factory Favourites.fromFirestore(DocumentSnapshot<Map<String, dynamic>> doc) {
    Map? data = doc.data();
    return Favourites(
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
