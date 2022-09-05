import 'package:evier/database/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/category_page.dart';
import '../colors.dart';
<<<<<<< HEAD
=======
import '../database/productsData.dart';
>>>>>>> f7d45b19067c14f255d703a1e9d5b5dcc3321376

class CategoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var productData = Provider.of<List<ProductsData?>?>(context);
    var databaseServices = Provider.of<DatabaseServices?>(context);
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
                builder: (context) => StreamProvider.value(
                  initialData: null,
                  value: databaseServices!.products(),
                  child: CategoryPage(
                    cat: actualCat[index],
                  ),
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
