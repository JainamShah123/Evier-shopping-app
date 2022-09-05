import 'package:evier/database/user_data.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../colors.dart';
import '../database/database.dart' show ProductsData;
import '../resources/products.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    var productsData = Provider.of<List<ProductsData?>?>(context);
    var userData = Provider.of<UserData?>(context);
    if (productsData == null) {
      return Center(
        child: CircularProgressIndicator(
          backgroundColor: shrineBrown600,
        ),
      );
    }

    if (productsData.isEmpty)
      return Center(
        child: Text(AppLocalizations.of(context)!.noProducts),
      );
    return Scrollbar(
      child: Container(
        padding: EdgeInsets.only(left: 8, right: 8, top: 8),
        child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: (kIsWeb &&
                      MediaQuery.of(context).size.height <
                          MediaQuery.of(context).size.width)
                  ? 5
                  : 2,
              childAspectRatio: 1 / 1.3,
            ),
            itemCount: productsData.length,
            itemBuilder: (ctx, index) {
              if (productsData[index]!.sold == false) {
                return Products(
                  productData: productsData[index]!,
                  userData: userData,
                );
              }
              return Container();
            }),
      ),
    );
  }
}
