import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// ignore: must_be_immutable
class BottomNavigationBarWidget extends StatelessWidget {
  int selectedIndex;
  Function(int index)? itemTapped;
  BottomNavigationBarWidget({this.selectedIndex = 0, this.itemTapped});
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: selectedIndex,
      type: BottomNavigationBarType.fixed,
      onTap: itemTapped,
      items: [
        BottomNavigationBarItem(
          icon: FaIcon(FontAwesomeIcons.home),
          label: "Home",
        ),
        BottomNavigationBarItem(
          icon: FaIcon(FontAwesomeIcons.list),
          label: "Categories",
        ),
        BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.heart), label: "Favourite"),
        BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.userCircle), label: "Profile"),
      ],
    );
  }
}
