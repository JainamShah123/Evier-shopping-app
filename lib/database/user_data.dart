import 'package:cloud_firestore/cloud_firestore.dart';

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

  factory UserData.fromFirestore(DocumentSnapshot doc) {
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
