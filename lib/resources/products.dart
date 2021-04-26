import 'package:evier/colors.dart';
import 'package:evier/database/database_services.dart';
import 'package:evier/screens/product_screen.dart';
import 'package:flutter/material.dart';

class Products extends StatefulWidget {
  final String? url;
  final String? title;
  final String? price;
  final String? description;
  final String? id;
  final String? category;
  final String? seller;
  final String? company;

  const Products({
    Key? key,
    required this.seller,
    required this.id,
    required this.url,
    required this.title,
    required this.category,
    required this.price,
    required this.description,
    required this.company,
  }) : super(key: key);

  @override
  _ProductsState createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  void setCart(BuildContext ctx) async {
    bool cartIsSet = await DatabaseServices().cartIsSet(widget.id!);

    if (!cartIsSet) {
      await DatabaseServices().setCart(
        company: widget.company!,
        category: widget.category!,
        id: widget.id!,
        price: widget.price!,
        productName: widget.title!,
        seller: widget.seller!,
        description: widget.description!,
        imageUrl: widget.url!,
      );
    } else {
      ScaffoldMessenger.of(ctx).showSnackBar(
        SnackBar(
          content: Text("Already added in cart"),
        ),
      );
    }
  }

  void setFav(BuildContext ctx) async {
    bool favIsSet = await DatabaseServices().favIsSet(widget.id!);
    if (!favIsSet) {
      await DatabaseServices().setFavourite(
        company: widget.company!,
        category: widget.category!,
        id: widget.id!,
        price: widget.price!,
        productName: widget.title!,
        seller: widget.seller!,
        description: widget.description ?? "",
        imageUrl: widget.url!,
      );
      setState(() {
        favIsSet = true;
      });
    } else {
      ScaffoldMessenger.of(ctx).showSnackBar(
        SnackBar(
          content: Text("Already added in favourites"),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (ctx) => ProductScreen(
                  description: widget.description,
                  price: widget.price,
                  title: widget.title,
                  url: widget.url,
                )));
      },
      child: Card(
        borderOnForeground: true,
        elevation: 0,
        color: shrineBackgroundWhite,
        shadowColor: Colors.transparent,
        shape: BeveledRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Container(
                margin: EdgeInsets.only(top: 2),
                height: 130,
                width: 150,
                child: Image.network(
                  widget.url!,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              "Name: ${widget.title!}".toUpperCase(),
              style: Theme.of(context).textTheme.bodyText1,
            ),
            Text(
              "Price: ₹${widget.price!}",
              style: Theme.of(context).textTheme.bodyText2,
            ),
          ],
        ),
      ),
    );
  }
}
