import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ProductScreen extends StatelessWidget {
  final String? url;
  final String? title;
  final String? price;
  final String? description;

  const ProductScreen({
    Key? key,
    this.url,
    this.title,
    this.price,
    this.description,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title!),
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
                child: Image.network(url!),
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
                          "Product Name: ${title!}",
                          style: TextStyle(
                            fontSize: 22,
                          ),
                        ),
                        Divider(),
                        Text(
                          "MRP: ${price!}",
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
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    child: TextButton(
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
