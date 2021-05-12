import 'package:evier/resources/products.dart';
import 'package:flutter/material.dart';

class SearchScreen extends SearchDelegate {
  List<Products> products = [];
  final cities = [
    "WashBasen",
    "ShowerTube",
    "Health Facient",
    "Floor trap",
  ];

  final recentCities = [
    "WashBasen",
    "ShowerTube",
    "Health Facient",
    "Floor trap",
  ];
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(icon: Icon(Icons.clear), onPressed: () {}),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: AnimatedIcon(
            icon: AnimatedIcons.menu_arrow, progress: transitionAnimation),
        onPressed: () {});
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container(
      child: Text("Data"),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionList = query.isEmpty
        ? recentCities
        : cities.where((p) => p.startsWith(query)).toList();

    return ListView.builder(
      itemCount: suggestionList.length,
      itemBuilder: (context, index) => ListTile(
        onTap: () {
          showResults(context);
        },
        leading: Icon(Icons.location_city),
        title: RichText(
          text: TextSpan(
            text: suggestionList[index].substring(0, query.length),
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
            children: [
              TextSpan(
                text: suggestionList[index].substring(query.length),
                style: TextStyle(color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
