import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  static String routeName = "HomeScreen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
           children: [
             ListTile(title: Text("Home"),),

           ],
        ),
      ),
      appBar: AppBar(

        title: Center(
          child: Text("Evier"),

        ),

      ),

    );
  }
}
