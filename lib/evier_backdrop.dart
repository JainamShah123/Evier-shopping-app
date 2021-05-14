import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:backdrop/backdrop.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import './colors.dart';
import './database/database.dart' show ProductsData, UserData;

import '../screens/search.dart';
import './screens/screens.dart'
    show ProductScreen, SellerProductScreen, HomeScreen;

import './authentication/auth.dart';

class EvierBackDrop extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var auth = Provider.of<Auth>(context);
    var userData = Provider.of<UserData?>(context);
    return BackdropScaffold(
      appBar: BackdropAppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () async {
              try {
                ProductsData? result = await showSearch<ProductsData?>(
                  context: context,
                  delegate: EvierSearch(),
                );

                if (result != null)
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => ProductScreen(
                        productsData: result,
                      ),
                    ),
                  );
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      e.toString(),
                    ),
                  ),
                );
              }
            },
          ),
        ],
        leading: BackdropToggleButton(
          icon: AnimatedIcons.close_menu,
          color: shrineBrown900,
        ),
        title: Text(
          AppLocalizations.of(context)!.title,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: shrinePink100,
        iconTheme: IconThemeData(color: shrineBrown900),
        actionsIconTheme: IconThemeData(color: shrineBrown900),
      ),
      backLayer: ListView(
        children: [
          if (userData!.type == "Seller")
            ListTile(
              leading: Icon(
                FontAwesomeIcons.inbox,
                color: shrineBrown600,
              ),
              title: Text(
                AppLocalizations.of(context)!.yourProducts,
                style: Theme.of(context).textTheme.bodyText1,
              ),
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => SellerProductScreen(),
                ),
              ),
            ),
          ListTile(
            onTap: () async {
              await auth.logout();
            },
            title: Text(
              'Logout',
              style: Theme.of(context).textTheme.bodyText1,
            ),
            leading: Icon(
              FontAwesomeIcons.signOutAlt,
              color: shrineBrown600,
            ),
          ),
        ],
      ),
      frontLayer: HomeScreen(),
    );
  }
}
