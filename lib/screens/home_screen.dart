import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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

    return Scaffold(
      body: _pages[_selectedIndex]['page'] as Widget?,
      bottomNavigationBar: (kIsWeb &&
              MediaQuery.of(context).size.height <
                  MediaQuery.of(context).size.width)
          ? null
          : BottomNavigationBarWidget(
              selectedIndex: _selectedIndex,
              itemTapped: selectPage,
            ),
    );
  }
}
