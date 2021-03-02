import 'package:flutter/material.dart';

class HealthFarProduct extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("HealthFacuent"),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          children: [
            Container(
              margin: EdgeInsets.only(top: 50),
              child: Padding(
                padding: const EdgeInsets.all(50),
                child: Image.asset("assests/7.png"),
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
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Text(
                        "Buy Now",
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Text("Add To Cart"),
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
