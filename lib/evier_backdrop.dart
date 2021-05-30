import 'package:evier/database/seller_product_data.dart';
import 'package:flutter/foundation.dart';
import 'package:evier/database/cart.dart';
import 'package:evier/database/database_services.dart';
import 'package:evier/database/favourites.dart';
import 'package:evier/database/productsData.dart';
import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import './screens/screens.dart';

import 'package:backdrop/app_bar.dart';
import 'package:backdrop/button.dart';
import 'package:backdrop/scaffold.dart';
import 'package:evier/authentication/auth.dart';
import 'package:evier/database/database.dart';
import 'package:evier/screens/Search.dart';
import 'package:evier/screens/product_screen.dart';
import 'package:evier/screens/seller_product_screen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'colors.dart';
import 'database/productsData.dart';

import './database/database.dart';

class EvierBackDrop extends StatefulWidget {
  @override
  _EvierBackDropState createState() => _EvierBackDropState();
}

class _EvierBackDropState extends State<EvierBackDrop> {
  @override
  Widget build(BuildContext context) {
    var database = Provider.of<DatabaseServices?>(context);
    return MultiProvider(
      providers: [
        StreamProvider<UserData?>.value(
          value: database!.userData(),
          initialData: null,
        ),
        StreamProvider<List<ProductsData?>?>(
          create: (context) => database.products(),
          initialData: null,
        ),
        StreamProvider<List<Favourites?>?>(
          create: (context) => database.favourites(),
          initialData: null,
        ),
        StreamProvider<List<Cart?>?>(
          create: (context) => database.cart(),
          initialData: null,
        ),
      ],
      child: Backdrop(),
    );
  }
}

class Backdrop extends StatefulWidget {
  @override
  _BackdropState createState() => _BackdropState();
}

class _BackdropState extends State<Backdrop> {
  int _selectedIndex = 0;

  void selectPage(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    var database = Provider.of<DatabaseServices?>(context);
    final List<Map<String, Object>> _pages = [
      {
        'page': HomePage(),
        'title': AppLocalizations.of(context)!.title,
      },
      {
        'page': CategoryScreen(),
        'title': AppLocalizations.of(context)!.categoryTitle,
      },
      {
        'page': FavouriteScreen(),
        'title': AppLocalizations.of(context)!.favouriteTitle,
      },
      {
        'page': CartScreen(),
        'title': AppLocalizations.of(context)!.cart,
      },
      {
        'page': AccountScreen(),
        'title': AppLocalizations.of(context)!.profile,
      },
    ];
    var auth = Provider.of<Auth>(context);
    var userData = Provider.of<UserData?>(context);
    return BackdropScaffold(
      bottomNavigationBar: (kIsWeb &&
              MediaQuery.of(context).size.height <
                  MediaQuery.of(context).size.width)
          ? null
          : BottomNavigationBarWidget(
              selectedIndex: _selectedIndex,
              itemTapped: selectPage,
            ),
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
                      builder: (context) => StreamProvider.value(
                        initialData: null,
                        value: database!.userData(),
                        child: ProductScreen(
                          productsData: result,
                        ),
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
          if (userData?.type == "Seller")
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
                  builder: (context) => MultiProvider(
                    providers: [
                      StreamProvider<List<SellerProductData?>?>.value(
                        value: database!.sellerProducts(),
                        initialData: null,
                      ),
                      StreamProvider.value(
                        value: database.userData(),
                        initialData: null,
                      ),
                    ],
                    child: SellerProductScreen(),
                  ),
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
      frontLayer: _pages[_selectedIndex]['page'] as Widget,
    );
  }
}
