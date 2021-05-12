import 'package:evier/resources/CategoryModel.dart';
import 'package:flutter/material.dart';

class CategoryScreen extends StatefulWidget {
  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  List<CategoryModel>? category = [];

  @override
  void initState() {
    super.initState();
    category = getData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GridView.builder(
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (context, index) => Card(
          child: CategoryTile(
            categoryName: category?[index].name,
            imageurl: category?[index].url,
          ),
        ),
        itemCount: category?.length,
      ),
    );
  }
}

class CategoryTile extends StatelessWidget {
  final imageurl;
  final categoryName;

  CategoryTile({this.imageurl, this.categoryName});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Stack(
        children: [
          Container(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                imageurl,
                fit: BoxFit.contain,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
