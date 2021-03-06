import 'package:evier/screens/cart_screen.dart';
import 'package:evier/screens/product_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Products extends StatelessWidget {
  final String? url;
  final String? title;
  final String? price;
  final String? description;

  const Products({
    Key? key,
    this.url,
    this.title,
    this.price,
    this.description,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0.0,
      // shape: StadiumBorder(
      //     // side: BorderSide(
      //     //     //   color: Color.fromARGB(
      //     //     //     255,
      //     //     //     Random().nextInt(255),
      //     //     //     Random().nextInt(255),
      //     //     //     Random().nextInt(255),
      //     //     //   ),
      //     //     // width: 1.7,
      //     //     ),
      //     // borderRadius: BorderRadius.circular(25),
      //     ),

      child: Container(
        padding: const EdgeInsets.all(8),
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (ctx) => ProductScreen(
                  title: title,
                  description: description,
                  price: price,
                  url: url,
                ),
              ),
            );
          },
          child: Stack(
            children: [
              Image.network(url!),
              Align(
                alignment: Alignment.bottomCenter,
                child: ListTile(
                  tileColor: Colors.white,
                  title: Text(
                    title!,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                  ),
                  subtitle: Text(
                    '₹$price',
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
                  Icon(
                    Icons.favorite_border_sharp,
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
