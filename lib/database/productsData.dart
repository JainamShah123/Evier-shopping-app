import 'package:cloud_firestore/cloud_firestore.dart';

class ProductsData {
  String? id;
  String? productName;
  String? price;
  String? seller;
  String? category;
  String? description;
  String? imageUrl;

  ProductsData({
    this.id,
    this.productName,
    this.price,
    this.seller,
    this.category,
    this.description,
    this.imageUrl,
  });

  factory ProductsData.fromFirestore(DocumentSnapshot doc) {
    Map? data = doc.data();
    return ProductsData(
      id: doc.id,
      productName: data?['name'],
      price: data?['price'],
      seller: data?['seller'],
      category: data?['category'],
      description: data?['descripttion'],
      imageUrl: data?['imageUrl'],
    );
  }
}
