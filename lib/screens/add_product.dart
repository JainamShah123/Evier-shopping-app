// ignore: avoid_web_libraries_in_flutter
// import 'dart:html' as web;
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:firebase_storage/firebase_storage.dart';

import 'package:image_picker/image_picker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:evier/resources/strings.dart';
import 'package:provider/provider.dart';

class AddProductScreen extends StatefulWidget {
  @override
  _AddProductScreenState createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  User user = FirebaseAuth.instance.currentUser!;
  CollectionReference productDatabase =
      FirebaseFirestore.instance.collection("products");

  FirebaseStorage storage = FirebaseStorage.instance;
  String? productPrice, productCategory, productCompany, productDescription;
  String? nameOfProduct;
  final key = GlobalKey<FormState>();
  String? location;
  String? imageUrl;
  PickedFile? imagePicker;
  bool imagePickedFromFile = false, imagePickedFromWeb = false;
  final picker = ImagePicker();
  // web.InputElement uploadInput;
  File? file;
  Uri? downloadUri;
  String? urlOfImage;
  String? sellerName;
  String? optionText;

  Future<void> uploadFile(File files) async {
    Reference storageReference = storage
        .ref()
        .child("/product_images")
        .child(DateTime.now().toString() + '.jpg');
    var storageTaskSnapshot = await storageReference.putFile(files);
    imageUrl = await storageTaskSnapshot.ref.getDownloadURL();
    // imageUrl = storageTaskSnapshot.toString();

    // imageUrl = imageUrl1.toString();
  }

  void startImagePicker() async {
    imagePicker = await picker.getImage(
      source: ImageSource.camera,
      // imageQuality: 8,
      maxHeight: 200,
      maxWidth: 200,
    );
    file = File(imagePicker!.path);

    if (file != null) {
      await uploadFile(file!);
      setState(() {
        imagePickedFromFile = true;
      });
    }
  }

  void onSave() async {
    if (key.currentState!.validate()) {
      key.currentState!.save();
      await FirebaseFirestore.instance
          .collection("user")
          .doc(user.uid)
          .get()
          .then((value) => sellerName = value.data()!['type'].toString());

      productDatabase.add({
        'price': productPrice!,
        'name': nameOfProduct!,
        'description': productDescription!,
        'imageUrl': imageUrl.toString(),
        'category': productCategory!,
        'seller': sellerName,
      }).whenComplete(() => Navigator.pop(context));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Strings.addProduct),
        centerTitle: true,
        actions: [
          IconButton(
            icon: FaIcon(FontAwesomeIcons.solidSave),
            onPressed: () {},
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Form(
          key: key,
          child: ListView(
            children: [
              Container(
                height: 200,
                width: 200,
                child: imagePickedFromFile
                    ? Image.file(file!)
                    : Center(
                        child: Icon(
                          Icons.camera,
                        ),
                      ),
              ),
              Container(
                width: 200,
                child: RaisedButton(
                  onPressed: startImagePicker,
                  child: Text(
                    "Pick File",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                key: UniqueKey(),
                // keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  hintText: "product Name",
                  // prefixIcon: Icon(Icons.mail_outline_rounded),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Strings.productNameError";
                  }
                  return null;
                },
                onSaved: (value) {
                  nameOfProduct = value!;
                },
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                keyboardType: TextInputType.numberWithOptions(
                  decimal: true,
                ),
                decoration: InputDecoration(
                  hintText: Strings.priceHint,
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return Strings.priceError;
                  }
                  return null;
                },
                onSaved: (value) {
                  productPrice = value;
                },
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                // keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  hintText: Strings.categoryTitle,
                  // prefixIcon: Icon(Icons.mail_outline_rounded),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return Strings.categoryError;
                  }
                  return null;
                },
                onSaved: (value) {
                  productCategory = value;
                },
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                // keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  hintText: Strings.companyTitle,
                  // prefixIcon: Icon(Icons.mail_outline_rounded),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return Strings.companyError;
                  }
                  return null;
                },
                onSaved: (value) {
                  productCompany = value;
                },
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                maxLines: 15,
                decoration: InputDecoration(
                  hintText: Strings.productDescription,
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return Strings.productDescriptionError;
                  }
                  return null;
                },
                onSaved: (value) {
                  productDescription = value;
                },
              ),
              SizedBox(
                height: 20,
              ),
              Center(
                child: Container(
                  height: 45,
                  width: 160,
                  child: ElevatedButton(
                    onPressed: () => onSave(),
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.blue),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.login),
                        SizedBox(width: 20),
                        Text(
                          Strings.register,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
