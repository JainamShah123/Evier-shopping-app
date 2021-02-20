import 'package:evier/screens/bottom_navigation_bar_widget.dart';
import 'package:flutter/material.dart';
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
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _pages[_selectedIndex]['title'],
        ),
      ),
      body: _pages[_selectedIndex]['page'],
      bottomNavigationBar: BottomNavigationBarWidget(
        selectedIndex: _selectedIndex,
        itemTapped: selectPage,
      ),
    );
  }
}
