import 'package:cloud_firestore/cloud_firestore.dart';

class Favourites {
  String? id;
  Favourites(this.id);
  factory Favourites.fromFirestore(DocumentSnapshot doc) {
    return doc.data()!['id'];
  }
}
