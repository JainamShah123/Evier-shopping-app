import 'package:evier/screens/evier_drawer.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import './screens.dart';
import '../resources/strings.dart';
import '../resources/routes.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  final _key = GlobalKey<FormState>();

  final List<Map<String, Object>> _pages = [
    {
      'page': HomePage(),
      'title': Strings.title,
    },
    {
      'page': CategoryScreen(),
      'title': Strings.categoryTitle,
    },
    {
      'page': FavouriteScreen(),
      'title': Strings.favouriteTitle,
    },
    {
      'page': AccountScreen(),
      'title': Strings.accountTitle,
    },
  ];

  void selectPage(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget appBarPanel(List<Map<String, Object>> pages) => AppBar(
        actions: [
          (kIsWeb &&
                  MediaQuery.of(context).size.height <
                      MediaQuery.of(context).size.width)
              ? Builder(builder: (context) {
                  return Container(
                    padding: EdgeInsets.all(5),
                    alignment: Alignment.center,
                    height: Scaffold.of(context).appBarMaxHeight,
                    width: 700,
                    child: Form(
                      key: _key,
                      child: TextFormField(
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(40),
                            borderSide: BorderSide(
                              color: Colors.white,
                              style: BorderStyle.solid,
                            ),
                          ),
                          hintText: Strings.search,
                          hintStyle: TextStyle(color: Colors.white),
                          focusColor: Colors.white,
                          fillColor: Colors.white,
                          prefixIcon: Icon(
                            Icons.search,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  );
                })
              : Container(
                  padding: EdgeInsets.only(
                    right: 20,
                  ),
                  child: Icon(Icons.search)),
          (kIsWeb &&
                  MediaQuery.of(context).size.height <
                      MediaQuery.of(context).size.width)
              ? SizedBox(
                  width: 10,
                )
              : Container(),
          (kIsWeb &&
                  MediaQuery.of(context).size.height <
                      MediaQuery.of(context).size.width)
              ? InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, Routes.accountRoute);
                  },
                  child: Icon(
                    Icons.account_circle_outlined,
                    size: 40,
                  ))
              : Container(),
          (kIsWeb &&
                  MediaQuery.of(context).size.height <
                      MediaQuery.of(context).size.width)
              ? SizedBox(
                  width: 10,
                )
              : Container(),
        ],
        leading: Center(
          child: Builder(
            builder: (BuildContext context) => IconButton(
              onPressed: () => Scaffold.of(context).openDrawer(),
              icon: FaIcon(
                FontAwesomeIcons.bars,
              ),
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            ),
          ),
        ),
        centerTitle: (kIsWeb &&
                MediaQuery.of(context).size.height <
                    MediaQuery.of(context).size.width)
            ? null
            : true,
        title: Text(
          pages[_selectedIndex]['title'] as String,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      );

  @override
  Widget build(BuildContext context) {
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
