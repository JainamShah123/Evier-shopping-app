import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import '../authentication/auth.dart';

class AccountScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: RaisedButton(
        child: Text("Logout"),
        onPressed: () {
          Auth().logout();
        },
      ),
    );
  }
}
