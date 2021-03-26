import 'package:evier/screens/seller_product_screen.dart';
import 'package:evier/screens/user_detail_edit.dart';
import 'package:evier/wrapper.dart';
import 'package:flutter/material.dart';
import './resources/strings.dart';
import './screens/screens.dart';
import './resources/themes.dart';
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
