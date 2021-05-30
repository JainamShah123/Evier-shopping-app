import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../screens/update_product.dart';
import '../colors.dart';
import '../database/database.dart'
    show DatabaseServices, ProductsData, UserData;

// ignore: must_be_immutable
class ProductScreen extends StatefulWidget {
  final ProductsData productsData;

  ProductScreen({
    required this.productsData,
  });

  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  late UserData? userData;
  late DatabaseServices? databaseServices;

  void click() {}

  void updateProduct(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => UpdateProductScreen(
          imageUrl: widget.productsData.imageUrl,
          productCategory: widget.productsData.category,
          nameOfProduct: widget.productsData.productName,
          productCompany: widget.productsData.company,
          productDescription: widget.productsData.description,
          productPrice: widget.productsData.price,
          sellerId: widget.productsData.seller,
          id: widget.productsData.id,
          sold: widget.productsData.sold,
        ),
      ),
    );
  }

  void addToCart(BuildContext context) async {
    if (await databaseServices!.cartIsSet(widget.productsData.id!)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Product already added in cart"),
        ),
      );
      return;
    }
    await databaseServices!
        .setCart(
          id: widget.productsData.id!,
          productName: widget.productsData.productName!,
          category: widget.productsData.category!,
          seller: widget.productsData.seller!,
          price: widget.productsData.price!,
          description: widget.productsData.description!,
          imageUrl: widget.productsData.imageUrl!,
          company: widget.productsData.company!,
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
      await databaseServices!.markProductAsSold(
        id: widget.productsData.id!,
        category: widget.productsData.category!,
        company: widget.productsData.company!,
        description: widget.productsData.description!,
        price: widget.productsData.price!,
        seller: widget.productsData.seller!,
        title: widget.productsData.productName!,
        url: widget.productsData.imageUrl!,
      );
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
    setState(() {
      widget.productsData.sold = true;
    });
  }

  void backToStock(BuildContext context) async {
    try {
      await databaseServices!.backToStock(
        id: widget.productsData.id!,
        category: widget.productsData.category!,
        company: widget.productsData.company!,
        description: widget.productsData.description!,
        price: widget.productsData.price!,
        seller: widget.productsData.seller!,
        title: widget.productsData.productName!,
        url: widget.productsData.imageUrl!,
      );
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
    setState(() {
      widget.productsData.sold = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    databaseServices = Provider.of<DatabaseServices?>(context);
    var user = Provider.of<User?>(context);
    userData = Provider.of<UserData?>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.productsData.productName!.toUpperCase()),
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
                    widget.productsData.imageUrl!,
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
                      widget.productsData.productName!.toUpperCase(),
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    IconButton(
                      icon: Icon(FontAwesomeIcons.heart),
                      onPressed: () async {
                        if (await DatabaseServices()
                            .favIsSet(widget.productsData.id!)) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content:
                                  Text("Product already added in favourites"),
                            ),
                          );
                          return;
                        }
                        await databaseServices!
                            .setFavourite(
                              id: widget.productsData.id!,
                              productName: widget.productsData.productName!,
                              category: widget.productsData.category!,
                              seller: widget.productsData.seller!,
                              price: widget.productsData.price!,
                              description: widget.productsData.description!,
                              imageUrl: widget.productsData.imageUrl!,
                              company: widget.productsData.company!,
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
                  "₹${widget.productsData.price}",
                  style: Theme.of(context)
                      .textTheme
                      .headline6!
                      .copyWith(fontSize: 20),
                ),
                SizedBox(
                  height: 16,
                ),
                Text(
                  widget.productsData.description!,
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
                  userData!.type == "Seller" &&
                          widget.productsData.seller == user!.uid
                      ? widget.productsData.sold == true
                          ? backToStock(context)
                          : markAsSold(context)
                      : addToCart(context);
                },
                child: Text(
                  userData!.type == "Seller" &&
                          widget.productsData.seller == user!.uid
                      ? widget.productsData.sold == true
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
                  userData!.type == "Seller" &&
                          widget.productsData.seller == user!.uid
                      ? updateProduct(context)
                      : click();
                },
                child: Text(
                  userData!.type == "Seller" &&
                          widget.productsData.seller == user!.uid
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
