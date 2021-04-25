import 'package:evier/authentication/auth.dart';
import 'package:evier/authentication/login.dart';
import 'package:evier/database/database_services.dart';
import 'package:evier/database/user_data.dart';
import 'package:evier/resources/routes.dart';
import 'package:evier/screens/recent_orders.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class AccountScreen extends StatefulWidget {
  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  UserData? userData;
  @override
  void dispose() {
    userData = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<User?>(context);
    // var userData = Provider.of<UserData?>(context);
    // userData = context.watch<UserData?>();

    return StreamBuilder<UserData?>(
        stream: DatabaseServices().userData(),
        builder: (context, snapshot) {
          return ListView(
            padding: EdgeInsets.all(16),
            children: [
              Center(
                child: FaIcon(
                  FontAwesomeIcons.solidUserCircle,
                  color: Theme.of(context).primaryColor,
                  size: 70,
                ),
              ),
              ListTile(
                title: Center(
                    child: Text(
                  snapshot.data?.name ?? '',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                )),
                subtitle: Center(child: Text(user?.email ?? '')),
              ),
              Divider(
                thickness: 1,
              ),
              ListTile(
                leading: FaIcon(FontAwesomeIcons.phoneAlt),
                title: Text(
                  snapshot.data?.phoneNumber ?? "Please enter the phone number",
                ),
              ),
              ListTile(
                leading: FaIcon(FontAwesomeIcons.addressCard),
                title: Text(
                  snapshot.data?.address ?? "Please enter the address",
                ),
              ),
              ListTile(
                title: Text(
                  "Recent Orders",
                ),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (ctx) => RecentOrders(),
                    ),
                  );
                },
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Column(
                  children: [
                    ElevatedButton(
                      child: Text("Edit"),
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          Routes.userDetailEdit,
                        );
                      },
                    ),
                    TextButton(
                      onPressed: () async {
                        await Auth().logout();
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => Login(),
                          ),
                        );
                      },
                      child: Text('Logout'),
                    ),
                  ],
                ),
              ),
            ],
          );
        });
  }
}
