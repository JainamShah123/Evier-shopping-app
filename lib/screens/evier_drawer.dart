import 'package:evier/database/user_data.dart';
import 'package:evier/resources/routes.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class EvierDrawer extends StatefulWidget {
  @override
  _EvierDrawerState createState() => _EvierDrawerState();
}

class _EvierDrawerState extends State<EvierDrawer> {
  @override
  Widget build(BuildContext context) {
    User? user = Provider.of<User?>(context);
    UserData? userData = Provider.of<UserData?>(context);

    print(user!.uid.toString());

    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Column(
              children: [
                Center(
                  child: FaIcon(
                    FontAwesomeIcons.solidUserCircle,
                    color: Colors.white,
                    size: 70,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 15),
                  child: Center(
                    child: Text(
                      userData!.name ?? "name not set",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (userData.type == 'Seller')
            ListTile(
              onTap: () =>
                  Navigator.pushNamed(context, Routes.sellerProductRoute),
              leading: FaIcon(FontAwesomeIcons.objectGroup),
              title: Text("Your Products"),
            ),
        ],
      ),
    );
  }
}
