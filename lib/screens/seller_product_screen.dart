import 'package:evier/database/productsData.dart';
import 'package:evier/resources/products.dart';
import 'package:evier/resources/routes.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SellerProductScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var user = Provider.of<User?>(context);
    var products = Provider.of<List<ProductsData?>?>(context);
    var uid = user!.uid;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(AppLocalizations.of(context)!.yourProducts),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.pushNamed(context, Routes.addProductRoute);
            },
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.only(left: 8, right: 8, top: 8),
        child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: (kIsWeb &&
                      MediaQuery.of(context).size.height <
                          MediaQuery.of(context).size.width)
                  ? 5
                  : 2,
              childAspectRatio: 1.6 / 2,
            ),
            itemCount: products?.where((element) {
              if (element?.seller == user.uid) return true;
              return false;
            }).length,
            itemBuilder: (ctx, index) {
              if (products?[index]!.seller == uid)
                return Products(
                  title: products?[index]!.productName,
                  url: products?[index]!.imageUrl,
                  price: products?[index]!.price,
                  description: products?[index]!.description,
                );
              return SizedBox.shrink();
            }),
      ),
    );
  }
}
