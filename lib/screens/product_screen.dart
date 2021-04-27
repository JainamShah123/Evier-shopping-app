import 'package:evier/colors.dart';
import 'package:evier/database/database_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProductScreen extends StatelessWidget {
  final String url;
  final String title;
  final String price;
  final String description;
  final String id;
  final String seller;
  final String company;
  final String category;

  const ProductScreen({
    Key? key,
    required this.url,
    required this.title,
    required this.price,
    required this.description,
    required this.company,
    required this.id,
    required this.seller,
    required this.category,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title.toUpperCase()),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          // color: Colors.red[100],
          padding: EdgeInsets.only(top: 16, left: 16, right: 16),
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child: Column(
              // mainAxisAlignment: Main,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 300,
                  width: double.infinity,
                  child: Image.network(
                    url,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title.toUpperCase(),
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    IconButton(
                      icon: Icon(FontAwesomeIcons.heart),
                      onPressed: () async {
                        if (await DatabaseServices().favIsSet(id)) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content:
                                  Text("Product already added in favourites"),
                            ),
                          );
                          return;
                        }
                        await DatabaseServices()
                            .setFavourite(
                              id: id,
                              productName: title,
                              category: category,
                              seller: seller,
                              price: price,
                              description: description,
                              imageUrl: url,
                              company: company,
                            )
                            .whenComplete(
                              () => ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text("Favourite added"),
                                ),
                              ),
                            );
                      },
                    ),
                  ],
                ),
                SizedBox(
                  height: 32,
                ),
                Text(
                  "₹$price",
                  style: Theme.of(context)
                      .textTheme
                      .headline6!
                      .copyWith(fontSize: 20),
                ),
                SizedBox(
                  height: 16,
                ),
                Text(
                  description,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2!
                      .copyWith(fontSize: 18),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        margin: EdgeInsets.zero,
        padding: EdgeInsets.zero,
        height: 70,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              height: 50,
              width: 150,
              child: TextButton(
                onPressed: () async {
                  if (await DatabaseServices().cartIsSet(id)) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Product already added in cart"),
                      ),
                    );
                    return;
                  }
                  await DatabaseServices()
                      .setCart(
                        id: id,
                        productName: title,
                        category: category,
                        seller: seller,
                        price: price,
                        description: description,
                        imageUrl: url,
                        company: company,
                      )
                      .whenComplete(
                        () => ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Product added to cart"),
                          ),
                        ),
                      );
                },
                child: Text(
                  "Add to cart",
                  style: TextStyle(
                    color: shrineBrown900,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
            Container(
              height: 50,
              width: 150,
              child: ElevatedButton(
                onPressed: () {},
                child: Text(
                  "Buy now",
                  style: TextStyle(fontSize: 20),
                ),
                style: ElevatedButton.styleFrom(
                  elevation: 8,
                  shape: const BeveledRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(7)),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
