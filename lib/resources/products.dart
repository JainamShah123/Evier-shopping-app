import 'package:evier/database/database_services.dart';
import 'package:evier/screens/cart_screen.dart';
import 'package:evier/screens/product_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Products extends StatefulWidget {
  final String? url;
  final String? title;
  final String? price;
  final String? description;
  final String? id;
  final String? category;
  final String? seller;

  const Products({
    Key? key,
    this.seller,
    this.id,
    this.url,
    this.title,
    this.category,
    this.price,
    this.description,
  }) : super(key: key);

  @override
  _ProductsState createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0.0,
      child: Container(
        padding: const EdgeInsets.all(8),
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (ctx) => ProductScreen(
                  title: widget.title,
                  description: widget.description,
                  price: widget.price,
                  url: widget.url,
                ),
              ),
            );
          },
          child: Stack(
            children: [
              Image.network(widget.url!),
              Align(
                alignment: Alignment.bottomCenter,
                child: ListTile(
                  tileColor: Colors.white,
                  title: Text(
                    widget.title!,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                  ),
                  subtitle: Text(
                    '₹${widget.price}',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  trailing: InkWell(
                    child: FaIcon(
                      FontAwesomeIcons.shoppingCart,
                    ),
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (ctx) => CartScreen()));
                    },
                  ),
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton(
                    icon: DatabaseServices().favIsSet(widget.id!)
                        ? Icon(Icons.favorite_sharp)
                        : Icon(Icons.favorite_border_sharp),
                    onPressed: () async {
                      if (!DatabaseServices().favIsSet(widget.id!))
                        await DatabaseServices().setFavourite(
                          category: widget.category!,
                          id: widget.id!,
                          price: widget.price!,
                          productName: widget.title!,
                          seller: widget.seller!,
                          description: widget.description ?? "",
                          imageUrl: widget.url!,
                        );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
