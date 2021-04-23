import 'package:evier/database/database_services.dart';
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
  @override
  void dispose() {
    super.dispose();
  }

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
                    onTap: () => setCart(context),
                  ),
                ),
              ),
              IconButton(
                icon: FaIcon(FontAwesomeIcons.heart),
                onPressed: () => setFav(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
