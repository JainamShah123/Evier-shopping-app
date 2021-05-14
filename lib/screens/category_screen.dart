import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/category_page.dart';
import '../colors.dart';
import '../database/productsData.dart';

class CategoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var productData = Provider.of<List<ProductsData?>?>(context);
    List<String> category = [];
    productData!.forEach((element) {
      category.add(element!.category!);
    });

    List<String> actualCat = category.toSet().toList();

    return GridView.builder(
      padding: EdgeInsets.all(16),
      itemCount: actualCat.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16.0,
        mainAxisSpacing: 16.0,
      ),
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => CategoryPage(
                  cat: actualCat[index],
                ),
              ),
            );
          },
          child: Container(
            height: 100,
            width: 100,
            color: shrinePink50,
            child: Center(
              child: Text(
                actualCat[index].toUpperCase(),
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
