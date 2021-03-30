import 'package:flutter/material.dart';

import './wrapper.dart';
import './resources/strings.dart';
import './screens/screens.dart'
    show
        AccountScreen,
        RegistrationPage,
        AddProductScreen,
        SellerProductScreen,
        UserDetailEdit;
import 'resources/themes.dart';
import 'resources/routes.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: Strings.appTitle,
      theme: theme,
      home: Wrapper(),
      routes: {
        Routes.registerRoute: (context) => RegistrationPage(),
        Routes.accountRoute: (context) => AccountScreen(),
        Routes.sellerProductRoute: (context) => SellerProductScreen(),
        Routes.addProductRoute: (context) => AddProductScreen(),
        Routes.userDetailEdit: (context) => UserDetailEdit(),
      },
    );
  }
}
