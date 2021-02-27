import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 8, right: 8, top: 8),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: (kIsWeb &&
                  MediaQuery.of(context).size.height <
                      MediaQuery.of(context).size.width)
              ? 5
              : 2,
          childAspectRatio: 1.6 / 2,
        ),
        itemCount: 10,
        itemBuilder: (context, index) => Card(
          elevation: 0.0,
          shape: RoundedRectangleBorder(
            side: BorderSide(
              color: Color.fromARGB(
                255,
                Random().nextInt(255),
                Random().nextInt(255),
                Random().nextInt(255),
              ),
              width: 1.7,
            ),
            borderRadius: BorderRadius.circular(25),
          ),
          child: Container(
            padding: const EdgeInsets.all(8),
            child: Stack(
              children: [
                Image.asset("assests/4.png"),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: ListTile(
                    tileColor: Colors.white,
                    title: Text(
                      "Wash Basin",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                    ),
                    subtitle: Text(
                      "499",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    // trailing: Icon(Icons.shopping_cart),
                    trailing: FaIcon(FontAwesomeIcons.shoppingCart),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
