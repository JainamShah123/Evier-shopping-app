import 'package:evier/screens/Search.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:backdrop/backdrop.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import './colors.dart';
import './database/database.dart' show UserData;
import 'package:evier/screens/screens.dart'
    show HomeScreen, SellerProductScreen, Login;

import 'authentication/auth.dart';

class EvierBackDrop extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var userData = Provider.of<UserData?>(context);
    return BackdropScaffold(
      appBar: BackdropAppBar(
        actions: [
          IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                showSearch(
                  context: context,
                  delegate: SearchScreen(),
                );
              }),
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
              onTap: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => SellerProductScreen())),
            ),
          ListTile(
            onTap: () async {
              await Auth().logout();
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => Login(),
                ),
              );
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
