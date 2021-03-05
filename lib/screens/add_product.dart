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
  var user = FirebaseAuth.instance.currentUser!.displayName;
  CollectionReference productDatabase =
      FirebaseFirestore.instance.collection("products");
  FirebaseStorage storage = FirebaseStorage.instance;
  String? productName,
      productPrice,
      productCategory,
      productCompany,
      productDescription;
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
      imageQuality: 8,
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

  // Future<String> downloadUrl() async {
  //   return await storage
  //       .ref()
  //       .child('product_images')
  //       .child(urlOfImage)
  //       .getDownloadURL();
  // }

  // void _startFilePicker({Function(web.Blob files) onSelected}) async {
  //   web.InputElement uploadInput = web.FileUploadInputElement()
  //     ..accept = 'image/jpg';
  //   uploadInput.click();
  //   uploadInput.onChange.listen((event) {
  //     final webFile = uploadInput.files.first;
  //     final reader = web.FileReader();
  //     reader.readAsDataUrl(webFile);
  //     reader.onLoadEnd.listen((event) async {
  //       onSelected(webFile);

  //       print(imageUrl);
  //       print("done");
  //     });
  //   });
  // }

  // void uploadImageFromWeb() async {
  //   _startFilePicker(onSelected: (files) async {
  //     final urlOfImage1 = DateTime.now().toString() + '.jpg';
  //     print(urlOfImage1);
  //     urlOfImage = urlOfImage1;
  //     print(urlOfImage);
  //     final uploadTask = storage
  //         .ref()
  //         .child("/product_images")
  //         .child(urlOfImage)
  //         .putBlob(files);

  //     var image = await (await uploadTask).ref.getDownloadURL();
  //     imageUrl = image.toString();
  //     print(imageUrl);
  //     setState(() {
  //       imagePickedFromWeb = true;
  //     });
  //   });
  // }

  void onSave() {
    if (key.currentState!.validate()) {
      key.currentState!.save();
      productDatabase.add({
        'name': productName,
        'price': productPrice,
        'description': productDescription,
        'imageUrl': imageUrl.toString(),
        'category': productCategory,
        'seller': user.toString(),
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
              TextFormField(
                // keyboardType: TextInputType.name,
                decoration: InputDecoration(
                  hintText: Strings.productNameHint,
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return Strings.productNameError;
                  }
                  return null;
                },
                onSaved: (value) {
                  productName = value;
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
              addProductButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget addProductButton() {
    return Center(
      child: Container(
        height: 45,
        width: 160,
        child: ElevatedButton(
          onPressed: onSave,
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
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
    );
  }
}
