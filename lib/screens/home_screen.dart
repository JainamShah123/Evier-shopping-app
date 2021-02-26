import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evier/screens/add_product.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import './screens.dart';
import '../resources/strings.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
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
        centerTitle: true,
        title: Text(
          pages[_selectedIndex]['title'],
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
                      ? FlatButton.icon(
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
      bottomNavigationBar: BottomNavigationBarWidget(
        selectedIndex: _selectedIndex,
        itemTapped: selectPage,
      ),
    );
  }
}
