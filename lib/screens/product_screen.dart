import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../screens/update_product.dart';
import '../colors.dart';
import '../database/database.dart' show DatabaseServices, UserData;

// ignore: must_be_immutable
class ProductScreen extends StatefulWidget {
  final String url;
  final String title;
  final String price;
  final String description;
  final String id;
  final String seller;
  final String company;
  final String category;
  bool sold;

  ProductScreen({
    Key? key,
    required this.sold,
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
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  late DatabaseServices databaseServices;

  void click() {}

  void updateProduct(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => UpdateProductScreen(
          imageUrl: widget.url,
          productCategory: widget.category,
          nameOfProduct: widget.title,
          productCompany: widget.company,
          productDescription: widget.description,
          productPrice: widget.price,
          sellerId: widget.seller,
          id: widget.id,
          sold: widget.sold,
        ),
      ),
    );
  }

  void addToCart(BuildContext context) async {
    if (await DatabaseServices().cartIsSet(widget.id)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Product already added in cart"),
        ),
      );
      return;
    }
    await databaseServices
        .setCart(
          id: widget.id,
          productName: widget.title,
          category: widget.category,
          seller: widget.seller,
          price: widget.price,
          description: widget.description,
          imageUrl: widget.url,
          company: widget.company,
        )
        .whenComplete(
          () => ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Product added to cart"),
            ),
          ),
        );
  }

  void markAsSold(BuildContext context) async {
    try {
      await databaseServices.markProductAsSold(
        id: widget.id,
        category: widget.category,
        company: widget.company,
        description: widget.description,
        price: widget.price,
        seller: widget.seller,
        title: widget.title,
        url: widget.url,
      );
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
    setState(() {
      widget.sold = true;
    });
  }

  void backToStock(BuildContext context) async {
    try {
      await databaseServices.backToStock(
        id: widget.id,
        category: widget.category,
        company: widget.company,
        description: widget.description,
        price: widget.price,
        seller: widget.seller,
        title: widget.title,
        url: widget.url,
      );
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
    setState(() {
      widget.sold = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    databaseServices = Provider.of<DatabaseServices>(context);
    var user = Provider.of<User?>(context);
    var userData = Provider.of<UserData?>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title.toUpperCase()),
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
                    widget.url,
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
                      widget.title.toUpperCase(),
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    IconButton(
                      icon: Icon(FontAwesomeIcons.heart),
                      onPressed: () async {
                        if (await DatabaseServices().favIsSet(widget.id)) {
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
                              id: widget.id,
                              productName: widget.title,
                              category: widget.category,
                              seller: widget.seller,
                              price: widget.price,
                              description: widget.description,
                              imageUrl: widget.url,
                              company: widget.company,
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
                  "₹${widget.price}",
                  style: Theme.of(context)
                      .textTheme
                      .headline6!
                      .copyWith(fontSize: 20),
                ),
                SizedBox(
                  height: 16,
                ),
                Text(
                  widget.description,
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
                  userData!.type == "Seller" && widget.seller == user!.uid
                      ? widget.sold == true
                          ? backToStock(context)
                          : markAsSold(context)
                      : addToCart(context);
                },
                child: Text(
                  userData!.type == "Seller" && widget.seller == user!.uid
                      ? widget.sold == true
                          ? "Mark in Stock"
                          : "Mark as sold"
                      : "Add to cart",
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
                onPressed: () {
                  userData.type == "Seller" && widget.seller == user!.uid
                      ? updateProduct(context)
                      : click();
                },
                child: Text(
                  userData.type == "Seller" && widget.seller == user!.uid
                      ? "Update"
                      : "Buy now",
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
