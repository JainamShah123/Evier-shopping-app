import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../database/database.dart';

class EvierSearch extends SearchDelegate<ProductsData> {
  List<ProductsData?>? data;

  @override
  List<Widget> buildActions(BuildContext context) {
    data = Provider.of<List<ProductsData?>?>(context);
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(
          context,
          ProductsData(
            id: "",
            productName: "",
            price: "",
            seller: "",
            category: "",
            description: "",
            imageUrl: "",
            company: "",
            sold: null,
          ),
        );
      },
      icon: Icon(
        Icons.arrow_back_ios_new,
      ),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    if (data == null) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    if (data!.isEmpty) {
      return Text("No Data");
    }
    final result = data!.where(
        (element) => element!.productName!.toLowerCase().contains(query));
    return ListView(
      children: result
          .map((e) => ListTile(
                onTap: () {
                  close(context, e!);
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
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (data == null) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    if (data!.isEmpty) {
      return Text("No Data");
    }

    final result = data!.where(
        (element) => element!.productName!.toLowerCase().contains(query));
    return ListView(
      children: result
          .map((e) => ListTile(
                onTap: () {
                  close(context, e!);
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
    );
  }
}
