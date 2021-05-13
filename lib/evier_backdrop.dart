import 'package:evier/screens/search.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:backdrop/backdrop.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import './colors.dart';
import './database/database.dart' show UserData;
import '../screens/screens.dart'
    show HomeScreen, ProductScreen, SellerProductScreen;

import 'authentication/auth.dart';

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
                var result = await showSearch(
                  context: context,
                  delegate: EvierSearch(),
                );
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ProductScreen(
                      sold: result!.sold!,
                      url: result.imageUrl!,
                      title: result.productName!,
                      price: result.price!,
                      description: result.description!,
                      company: result.company!,
                      id: result.id!,
                      seller: result.seller!,
                      category: result.category!,
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
