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
        title: Text(title!.toUpperCase()),
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
                    url!,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                Text(
                  title!.toUpperCase(),
                  style: Theme.of(context).textTheme.headline5,
                ),
                SizedBox(
                  height: 32,
                ),
                Text(
                  "₹${price!}",
                  style: Theme.of(context)
                      .textTheme
                      .headline6!
                      .copyWith(fontSize: 20),
                ),
                SizedBox(
                  height: 16,
                ),
                Text(
                  description!,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2!
                      .copyWith(fontSize: 18),
                ),
                Expanded(
                  child: Align(
                    alignment: FractionalOffset.bottomCenter,
                    child: ButtonBar(
                      buttonHeight: double.infinity,
                      buttonMinWidth: double.infinity,
                      mainAxisSize: MainAxisSize.max,
                      alignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                          onPressed: () {},
                          child: Text("Add to cart"),
                        ),
                        ElevatedButton(
                          onPressed: () {},
                          child: Text("Buy now"),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
