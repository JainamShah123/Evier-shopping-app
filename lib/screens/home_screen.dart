import 'package:evier/database/cart.dart';
import 'package:evier/database/database_services.dart';
import 'package:evier/database/favourites.dart';
import 'package:evier/database/productsData.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import './screens.dart'
    show
        HomePage,
        CategoryScreen,
        FavouriteScreen,
        CartScreen,
        AccountScreen,
        BottomNavigationBarWidget;

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    var databaseServices = Provider.of<DatabaseServices?>(context);
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

    void selectPage(int index) {
      setState(() {
        _selectedIndex = index;
      });
    }

    return MultiProvider(
      providers: [
        StreamProvider<List<ProductsData?>?>(
          create: (context) => databaseServices!.products(),
          initialData: null,
        ),
        StreamProvider<List<Favourites?>?>(
          create: (context) => databaseServices!.favourites(),
          initialData: null,
        ),
        StreamProvider<List<Cart?>?>(
          create: (context) => databaseServices!.cart(),
          initialData: null,
        ),
      ],
      child: Scaffold(
        body: _pages[_selectedIndex]['page'] as Widget?,
        bottomNavigationBar: (kIsWeb &&
                MediaQuery.of(context).size.height <
                    MediaQuery.of(context).size.width)
            ? null
            : BottomNavigationBarWidget(
                selectedIndex: _selectedIndex,
                itemTapped: selectPage,
              ),
      ),
    );
  }
}
