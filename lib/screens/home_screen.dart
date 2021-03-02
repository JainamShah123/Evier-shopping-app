/// Flutter Core packages
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// FlutterFire plugins
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evier/screens/add_product.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

/// Custom widgets os screens or classes
import './screens.dart';
import '../resources/strings.dart';
import '../resources/routes.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0; // Index to map BottomNavigation
  final _key = GlobalKey<FormState>(); // Key to manage form

  // Route Map for bottom navigation bar
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
          pages[_selectedIndex]['title'],
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      );

  @override
  Widget build(BuildContext context) {
    CollectionReference query = FirebaseFirestore.instance.collection("users");
    final user = Provider.of<User>(context);
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            DrawerHeader(
              child: Text("Drawer"),
            ),
            FutureBuilder(
              future: FirebaseFirestore.instance
                  .collection('user')
                  .doc(user.uid)
                  .get(),
              builder: (ctx, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                if (snapshot.connectionState == ConnectionState.done) {
                  DocumentSnapshot documentSnapshot = snapshot.data;
                  return documentSnapshot.data()['type'] == 'Seller'
                      ? TextButton.icon(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AddProductScreen(),
                              ),
                            );
                          },
                          icon: Icon(Icons.add),
                          label: Text(Strings.addProduct),
                        )
                      : Container();
                }
                return Container();
              },
            ),
          ],
        ),
      ),
      backgroundColor: Colors.grey[200],
      appBar: appBarPanel(_pages),
      body: _pages[_selectedIndex]['page'],
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
