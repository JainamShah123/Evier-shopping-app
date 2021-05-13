import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:firebase_storage/firebase_storage.dart';

import 'package:image_picker/image_picker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:provider/provider.dart';

import '../database/database_services.dart';
import '../colors.dart';

// ignore: must_be_immutable
class UpdateProductScreen extends StatefulWidget {
  String? productPrice,
      productCategory,
      productCompany,
      productDescription,
      nameOfProduct,
      imageUrl,
      sellerId,
      id;

  bool? sold;

  UpdateProductScreen({
    required this.imageUrl,
    required this.productCategory,
    required this.nameOfProduct,
    required this.productCompany,
    required this.productDescription,
    required this.productPrice,
    required this.sellerId,
    required this.id,
    required this.sold,
  });

  @override
  _UpdateProductScreenState createState() => _UpdateProductScreenState();
}

class _UpdateProductScreenState extends State<UpdateProductScreen> {
  late DatabaseServices databaseService;

  FirebaseStorage storage = FirebaseStorage.instance;
  String? optionText, location;

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
    widget.imageUrl = await storageTaskSnapshot.ref.getDownloadURL();
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
                await databaseService
                    .updateProduct(
                      imageUrl: widget.imageUrl.toString(),
                      nameOfProduct: widget.nameOfProduct!,
                      productCategory: widget.productCategory!,
                      productCompany: widget.productCompany!,
                      productDescription: widget.productDescription!,
                      productPrice: widget.productPrice!,
                      sellerId: widget.sellerId!,
                      id: widget.id!,
                      sold: widget.sold!,
                    )
                    .onError(
                      (error, stackTrace) =>
                          ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            error.toString(),
                          ),
                        ),
                      ),
                    )
                    .whenComplete(() => Navigator.pop(context));
              },
              child: Text(
                "ADD",
                style: TextStyle(color: shrineBrown900),
              ),
            ),
            TextButton(
              onPressed: () {
                return Navigator.of(context).pop(false);
              },
              child: Text(
                "NO",
                style: TextStyle(color: shrineBrown900),
              ),
            ),
          ],
        ),
      ).whenComplete(() => Navigator.of(context).pop());
    }
  }

  @override
  Widget build(BuildContext context) {
    databaseService = Provider.of<DatabaseServices>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Update Product"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: FaIcon(FontAwesomeIcons.solidSave),
            onPressed: () {},
          ),
        ],
      ),
      body: Container(
        margin: EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 16),
        child: Form(
          key: key,
          child: ListView(
            children: [
              Container(
                height: 200,
                width: 200,
                child: widget.imageUrl == null
                    ? imagePickedFromFile
                        ? Image.network(widget.imageUrl!)
                        : Center(
                            child: Icon(
                              Icons.camera,
                            ),
                          )
                    : Image.network(widget.imageUrl!),
              ),
              Container(
                width: 200,
                child: ElevatedButton(
                  onPressed: startImagePicker,
                  style: ElevatedButton.styleFrom(
                    elevation: 8,
                    shape: const BeveledRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(7)),
                    ),
                  ),
                  child: Text(
                    "Pick File",
                    style: TextStyle(color: shrineBrown600),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                initialValue: widget.nameOfProduct,
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
                  widget.nameOfProduct = value!;
                },
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                initialValue: widget.productPrice,
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
                  widget.productPrice = value;
                },
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                initialValue: widget.productCategory,
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
                  widget.productCategory = value;
                },
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                initialValue: widget.productCompany,
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
                  widget.productCompany = value;
                },
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                initialValue: widget.productDescription,
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
                  widget.productDescription = value;
                },
              ),
              SizedBox(
                height: 20,
              ),
              Center(
                child: Container(
                  margin: EdgeInsets.only(bottom: 16),
                  height: 45,
                  width: 160,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 8,
                      shape: const BeveledRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(7)),
                      ),
                    ),
                    onPressed: () => onSave(),
                    child: Text(
                      AppLocalizations.of(context)!.addProduct.toUpperCase(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        color: shrineBrown600,
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
