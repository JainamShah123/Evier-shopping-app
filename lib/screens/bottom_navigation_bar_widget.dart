import 'package:evier/colors.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// ignore: must_be_immutable
class BottomNavigationBarWidget extends StatelessWidget {
  int selectedIndex;
  Function(int index)? itemTapped;
  BottomNavigationBarWidget({this.selectedIndex = 0, this.itemTapped});
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      elevation: 0.0,
      backgroundColor: shrinePink100,
      unselectedItemColor: shrineBrown600,
      selectedItemColor: shrineBrown900,
      currentIndex: selectedIndex,
      type: BottomNavigationBarType.fixed,
      onTap: itemTapped,
      items: [
        BottomNavigationBarItem(
          icon: FaIcon(
            FontAwesomeIcons.home,
          ),
          label: AppLocalizations.of(context)!.home,
        ),
        BottomNavigationBarItem(
          icon: FaIcon(FontAwesomeIcons.list),
          label: AppLocalizations.of(context)!.categoryTitle,
        ),
        BottomNavigationBarItem(
          icon: FaIcon(FontAwesomeIcons.heart),
          label: AppLocalizations.of(context)!.favouriteTitle,
        ),
        BottomNavigationBarItem(
          icon: FaIcon(FontAwesomeIcons.shoppingCart),
          label: AppLocalizations.of(context)!.cart,
        ),
        BottomNavigationBarItem(
          icon: FaIcon(FontAwesomeIcons.userCircle),
          label: AppLocalizations.of(context)!.profile,
        ),
      ],
    );
  }
}
