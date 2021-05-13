import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/product_screen.dart';
import '../database/database.dart';

class CategoryPage extends StatelessWidget {
  final String cat;

  const CategoryPage({
    Key? key,
    required this.cat,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var productData = Provider.of<List<ProductsData?>?>(context);
    var categoryProduct =
        productData!.where((element) => element!.category == cat);
    return Scaffold(
      appBar: AppBar(
        title: Text(cat),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.only(left: 8, right: 8, top: 8),
        child: ListView(
          children: categoryProduct
              .map((e) => ListTile(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => ProductScreen(
                            sold: e!.sold!,
                            url: e.imageUrl!,
                            title: e.productName!,
                            price: e.price!,
                            description: e.description!,
                            company: e.company!,
                            id: e.id!,
                            seller: e.seller!,
                            category: e.category!,
                          ),
                        ),
                      );
                    },
                    hoverColor: Colors.red,
                    title: Text(
                      "Product Name:  ${e!.productName}",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text("Product price:  ₹${e.price}"),
                    leading: Image.network(
                      e.imageUrl!,
                      fit: BoxFit.contain,
                      cacheHeight: 200,
                      cacheWidth: 200,
                    ),
                  ))
              .toList(),
        ),
      ),
    );
  }
}
