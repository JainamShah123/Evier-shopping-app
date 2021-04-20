import 'package:cloud_firestore/cloud_firestore.dart';

class Favourites {
  String? id;
  String? productName;
  String? price;
  String? seller;
  String? category;
  String? description;
  String? imageUrl;
  Favourites({
    this.id,
    this.productName,
    this.price,
    this.seller,
    this.category,
    this.description,
    this.imageUrl,
  });
  factory Favourites.fromFirestore(DocumentSnapshot doc) {
    Map? data = doc.data();
    return Favourites(
      id: doc.id,
      productName: data?['name'],
      price: data?['price'],
      seller: data?['seller'],
      category: data?['category'],
      description: data?['description'],
      imageUrl: data?['imageUrl'],
    );
  }
}
