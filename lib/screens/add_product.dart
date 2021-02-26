import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AddProductScreen extends StatefulWidget {
  @override
  _AddProductScreenState createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  String productName, productPrice, productCategory;
  final key = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add product"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: FaIcon(FontAwesomeIcons.solidSave),
            onPressed: () {},
          ),
        ],
      ),
      body: Form(
        key: key,
        child: ListView(
          children: [
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                hintText: "Product Name",
                prefixIcon: Icon(Icons.mail_outline_rounded),
              ),
              validator: (value) {
                if (value.isEmpty) {
                  return "Please enter the product name";
                }
                return null;
              },
              onSaved: (value) {
                productName = value;
              },
            ),
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                hintText: "Price",
                prefixIcon: Icon(Icons.mail_outline_rounded),
              ),
              validator: (value) {
                if (value.isEmpty) {
                  return "Please enter the product price";
                }
                return null;
              },
              onSaved: (value) {
                productPrice = value;
              },
            ),
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                hintText: "Category",
                prefixIcon: Icon(Icons.mail_outline_rounded),
              ),
              validator: (value) {
                if (value.isEmpty) {
                  return "Select category";
                }
                return null;
              },
              onSaved: (value) {
                productName = value;
              },
            ),
          ],
        ),
      ),
    );
  }
}
