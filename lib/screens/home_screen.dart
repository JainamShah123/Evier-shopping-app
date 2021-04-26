import 'package:evier/colors.dart';
import 'package:evier/screens/cart_screen.dart';
import 'package:evier/screens/drawer.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import './screens.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  final _key = GlobalKey<FormState>();

  Widget appBarPanel(List<Map<String, Object>> pages) => AppBar(
        elevation: 0.0,
        // backgroundColor: Colors.transparent,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Icon(
              FontAwesomeIcons.search,
            ),
          ),
        ],
        leading: Builder(
          builder: (BuildContext context) => IconButton(
            onPressed: () => Scaffold.of(context).openDrawer(),
            icon: Icon(
              FontAwesomeIcons.bars,
              color: shrineBrown900,
            ),
            tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
          ),
        ),
        centerTitle: (kIsWeb &&
                MediaQuery.of(context).size.height <
                    MediaQuery.of(context).size.width)
            ? null
            : true,
        title: Text(
          pages[_selectedIndex]['title'] as String,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: shrineBrown900,
            fontSize: Theme.of(context).textTheme.headline5!.fontSize,
          ),
        ),
      );

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
      drawer: EvierDrawer(),
      backgroundColor: Colors.grey[200],
      appBar: appBarPanel(_pages) as PreferredSizeWidget?,
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
