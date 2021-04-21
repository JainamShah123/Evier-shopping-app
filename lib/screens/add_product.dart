import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:firebase_storage/firebase_storage.dart';

import 'package:image_picker/image_picker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:provider/provider.dart';

class AddProductScreen extends StatefulWidget {
  @override
  _AddProductScreenState createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  CollectionReference productDatabase =
      FirebaseFirestore.instance.collection("products");

  FirebaseStorage storage = FirebaseStorage.instance;
  String? productPrice,
      productCategory,
      productCompany,
      productDescription,
      nameOfProduct,
      location,
      imageUrl,
      sellerId,
      optionText;
  final key = GlobalKey<FormState>();
  PickedFile? imagePicker;
  bool imagePickedFromFile = false, imagePickedFromWeb = false;
  final picker = ImagePicker();
  File? file;
  late Reference storageReference;
  late TaskSnapshot storageTaskSnapshot;

  Future<void> uploadFile(File files) async {
    storageReference = storage
        .ref()
        .child("/product_images")
        .child(DateTime.now().toString() + '.jpg');
    storageTaskSnapshot = await storageReference.putFile(files);
    imageUrl = await storageTaskSnapshot.ref.getDownloadURL();
  }

  void startImagePicker() async {
    imagePicker = await picker.getImage(
      source: ImageSource.camera,
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

      await showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text("Confirm"),
          content: Text("Are you sure you want to add the product"),
          actions: [
            TextButton(
              onPressed: () async {
                await productDatabase.add({
                  'price': productPrice!,
                  'name': nameOfProduct!,
                  'description': productDescription!,
                  'imageUrl': imageUrl.toString(),
                  'category': productCategory!,
                  'seller': sellerId,
                }).whenComplete(() => Navigator.of(context).pop());
              },
              child: Text("ADD"),
            ),
            TextButton(
              onPressed: () {
                return Navigator.of(context).pop(false);
              },
              child: Text("NO"),
            ),
          ],
        ),
      ).whenComplete(() => Navigator.of(context).pop());
    }
  }

  @override
  Widget build(BuildContext context) {
    User? user = Provider.of(context);
    sellerId = user!.uid;

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.addProduct),
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
                    ? Image.network(imageUrl!)
                    : Center(
                        child: Icon(
                          Icons.camera,
                        ),
                      ),
              ),
              Container(
                width: 200,
                child: ElevatedButton(
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
                decoration: InputDecoration(
                  hintText: AppLocalizations.of(context)!.productNameHint,
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return AppLocalizations.of(context)!.productNameError;
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
                  hintText: AppLocalizations.of(context)!.priceHint,
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return AppLocalizations.of(context)!.priceError;
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
                decoration: InputDecoration(
                  hintText: AppLocalizations.of(context)!.categoryTitle,
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return AppLocalizations.of(context)!.categoryError;
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
                decoration: InputDecoration(
                  hintText: AppLocalizations.of(context)!.companyTitle,
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return AppLocalizations.of(context)!.companyError;
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
                  hintText: AppLocalizations.of(context)!.productDescription,
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return AppLocalizations.of(context)!
                        .productDescriptionError;
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
                    child: Text(
                      AppLocalizations.of(context)!.addProduct,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
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
