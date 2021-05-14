import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evier/database/database.dart';

class SellerProductData {
  String? id;
  String? productName;
  String? price;
  String? seller;
  String? category;
  String? description;
  String? imageUrl;
  String? company;
  bool? sold;

  SellerProductData({
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

  factory SellerProductData.fromFirestore(DocumentSnapshot doc) {
    Map? data = doc.data();
    return SellerProductData(
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

  ProductsData toProductsData() {
    return ProductsData(
        id: this.id,
        productName: this.productName,
        price: this.price,
        seller: this.seller,
        category: this.category,
        description: this.description,
        imageUrl: this.imageUrl,
        company: this.company,
        sold: this.sold);
  }
}
