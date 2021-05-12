import 'package:cloud_firestore/cloud_firestore.dart';

class ProductsData {
  String? id;
  String? productName;
  String? price;
  String? seller;
  String? category;
  String? description;
  String? imageUrl;
  String? company;
  bool? sold;

  ProductsData({
    required this.id,
    required this.productName,
    required this.price,
    required this.seller,
    required this.category,
    required this.description,
    required this.imageUrl,
    required this.company,
    required this.sold,
  });

  factory ProductsData.fromFirestore(DocumentSnapshot doc) {
    Map? data = doc.data();
    return ProductsData(
      id: doc.id,
      sold: data?['sold_out'],
      company: data?['company'],
      productName: data?['name'],
      price: data?['price'],
      seller: data?['seller'],
      category: data?['category'],
      description: data?['description'],
      imageUrl: data?['imageUrl'],
    );
  }
}
