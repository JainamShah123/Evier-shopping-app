import 'package:evier/screens/category_all_screens/watertap_product.dart';
import 'package:flutter/material.dart';

import '../cart_screen.dart';

class WaterTap extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text("WaterTap"),
        ),
      ),
      body: ListView.builder(
        itemCount: 5,
        itemBuilder: (context, i) => Card(
          child: InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (ctx) => WaterTapProduct()));
            },
            child: Container(
              width: 200,
              height: 150,
              child: Stack(
                children: [
                  Container(
                    margin: EdgeInsets.all(25),
                    child: Image.asset("assests/8.jpg"),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Column(
                        children: [
                          Container(
                            margin: EdgeInsets.only(right: 15, top: 10),
                            child: Text(
                              "Company Name: Jaquar",
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(right: 23, top: 5),
                            child: Text(
                              "Product Name: WaterTap",
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(right: 140, top: 5),
                            child: Text(
                              "MRP: 499",
                              style: TextStyle(fontSize: 20, color: Colors.red),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (ctx) => CartScreen()));
                            },
                            child: Text(
                              "Go to Cart Page",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
