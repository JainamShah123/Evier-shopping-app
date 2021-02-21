import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// ignore: must_be_immutable
class BottomNavigationBarWidget extends StatelessWidget {
  int selectedIndex;
  Function(int index) itemTapped;
  BottomNavigationBarWidget({this.selectedIndex = 0, this.itemTapped});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(blurRadius: 20, color: Colors.black.withOpacity(.1))
      ]),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
          child: GNav(
            gap: 8,
            color: Colors.grey[800],
            activeColor: Colors.purple,
            iconSize: 24,
            tabBackgroundColor: Colors.purple.withOpacity(0.1),
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 14),
            duration: Duration(milliseconds: 500),
            tabs: [
              GButton(
                icon: FontAwesomeIcons.home,
                text: 'Home',
              ),
              GButton(
                icon: FontAwesomeIcons.list,
                text: 'Categories',
              ),
              GButton(
                icon: FontAwesomeIcons.heart,
                text: 'Favourite',
              ),
              GButton(
                icon: FontAwesomeIcons.userCircle,
                text: 'Profile',
              ),
            ],
            selectedIndex: selectedIndex,
            onTabChange: itemTapped,
          ),
        ),
      ),
    );
  }
}
