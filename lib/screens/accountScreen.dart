import 'package:flutter/material.dart';
import '../authentication/auth.dart';

// ignore: must_be_immutable
class AccountScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        child: Text("Logout"),
        onPressed: () async {
          Auth().logout();
        },
      ),
    );
  }
}
