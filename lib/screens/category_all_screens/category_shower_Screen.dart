// import 'package:evier/screens/home_page.dart';
import 'package:flutter/material.dart';

import '../cart_screen.dart';
import 'shower_product.dart';

class ShowerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Shower"),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: 5,
        itemBuilder: (context, i) => Card(
          // shape: RoundedRectangleBorder(
          //   side: BorderSide(
          //     color: Color.fromARGB(
          //       255,
          //       Random().nextInt(255),
          //       Random().nextInt(255),
          //       Random().nextInt(255),
          //     ),
          //     width: 3,
          //   ),
          //   borderRadius: BorderRadius.circular(25),
          // ),
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (ctx) => ShowerProduct(),
                ),
              );
            },
            child: Container(
              width: 200,
              height: 150,
              child: Stack(
                children: [
                  Container(
                    margin: EdgeInsets.all(25),
                    child: Image.asset("assests/5.png"),
                  ),
                  Row(mainAxisAlignment: MainAxisAlignment.end, children: [
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
                            "Product Name: Shower",
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
                          child: Text("Go to Cart Page"),
                        ),
                      ],
                    ),
                  ])
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
