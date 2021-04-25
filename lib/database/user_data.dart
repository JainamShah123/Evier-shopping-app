import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserData {
  String? address;
  String? name;
  String? phoneNumber;
  String? type;

  UserData({
    required this.address,
    required this.name,
    required this.phoneNumber,
    required this.type,
  });

  factory UserData.fromFirestore({
    required DocumentSnapshot doc,
    required User user,
  }) {
    return UserData(
      address: doc.data()?['address'],
      name: doc.data()?['name'],
      phoneNumber: doc.data()?['phonenumber'],
      type: doc.data()?['type'],
    );
  }

  factory UserData.initialData() {
    return UserData(
      address: '',
      name: '',
      phoneNumber: '',
      type: '',
    );
  }
}
