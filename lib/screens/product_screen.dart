import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ProductScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Wash Basin"),
        centerTitle: true,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          children: [
            Container(
              margin: EdgeInsets.only(top: 45),
              child: Padding(
                padding: const EdgeInsets.all(45),
                child: Image.asset("assests/4.png"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "This Product is Very Unique Color is So nice this Product",
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                        Divider(),
                        Text(
                          "Company Name: Jaquar",
                          style: TextStyle(
                            fontSize: 22,
                          ),
                        ),
                        Text(
                          "Product Name: Wash Basin",
                          style: TextStyle(
                            fontSize: 22,
                          ),
                        ),
                        Divider(),
                        Text(
                          "MRP: 499",
                          style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.red),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    child: RaisedButton(
                      onPressed: () {},
                      child: Text(
                        "Buy Now",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    child: RaisedButton(
                      onPressed: () {},
                      child: Text(
                        "Add To Cart",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
