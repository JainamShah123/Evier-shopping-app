import 'package:cloud_firestore/cloud_firestore.dart';
import '../screens/bottom_navigation_bar_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import './screens.dart';
import './home_page.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  /// This is List of Maps which Joins The Page with its title
  /// and Actions it needs to do

  final List<Map<String, Object>> _pages = [
    {
      'page': HomePage(),
      'title': 'Evier',
    },
    {
      'page': CategoryScreen(),
      'title': 'Category',
    },
    {
      'page': FavouriteScreen(),
      'title': 'Favorite',
    },
    {
      'page': AccountScreen(),
      'title': 'Account',
    },
  ];

  // Sets the index number as per the button is Clicked in Bottom Nav Bar
  void selectPage(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    CollectionReference query = FirebaseFirestore.instance.collection("users");
    final user = Provider.of<User>(context);

    return Scaffold(
      drawer: Drawer(),
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
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
          _pages[_selectedIndex]['title'],
        ),
      ),
      body: _pages[_selectedIndex]['page'],
      floatingActionButton: FutureBuilder(
        future:
            FirebaseFirestore.instance.collection('user').doc(user.uid).get(),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.connectionState == ConnectionState.done) {
            DocumentSnapshot documentSnapshot = snapshot.data;
            return documentSnapshot.data()['type'] == 'Seller'
                ? FloatingActionButton(
                    onPressed: null,
                    child: Icon(Icons.add),
                  )
                : Container();
          }
          return Container();
        },
      ),
      bottomNavigationBar: BottomNavigationBarWidget(
        selectedIndex: _selectedIndex,
        itemTapped: selectPage,
      ),
    );
  }
}
