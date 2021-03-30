import 'package:evier/database/productsData.dart';
import 'package:evier/resources/products.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var productsData = Provider.of<List<ProductsData?>?>(context);
    if (productsData == null)
      return Center(
        child: Text("Currently there are no products in our application"),
      );
    return Container(
      padding: EdgeInsets.only(left: 8, right: 8, top: 8),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: (kIsWeb &&
                  MediaQuery.of(context).size.height <
                      MediaQuery.of(context).size.width)
              ? 5
              : 2,
          childAspectRatio: 1.6 / 2,
        ),
        itemCount: productsData.length,
        itemBuilder: (ctx, index) => Products(
          title: productsData[index]?.productName,
          url: productsData[index]?.imageUrl,
          price: productsData[index]?.price.toString(),
          description: productsData[index]?.description,
        ),
      ),
    );
  }
}
