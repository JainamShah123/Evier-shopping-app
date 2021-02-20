import 'package:flutter/material.dart';
import 'resources/strings.dart';
import 'screens/screens.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:math';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: appTitle,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
          ),
        ),
        buttonTheme: ButtonThemeData(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Login(),
      routes: {
        RegistrationPage.routeName: (context) => RegistrationPage(),
        Wrapper.routeName: (context) => Wrapper(),
      },
    );
  }
}

class Wrapper extends StatefulWidget {
  static String routeName = "HomeScreen";

  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  int _selectedIndex = 0;
  final List<Widget> _screens = [
    HomeView(),
    CategoryScreen(),
    FavouriteScreen(),
    AccountScreen(),
  ];
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(),
      appBar: AppBar(
        toolbarHeight: 60,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(25),
          ),
        ),
        title: Center(
          child: Text(
            "Evier",
            style: TextStyle(
              fontSize: 30,
            ),
          ),
        ),
      ),
      body: _screens[_selectedIndex],
      bottomNavigationBar: Container(
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
                  icon: FontAwesomeIcons.heart,
                  text: 'Likes',
                ),
                GButton(
                  icon: FontAwesomeIcons.search,
                  text: 'Search',
                ),
                GButton(
                  icon: FontAwesomeIcons.userCircle,
                  text: 'Profile',
                ),
              ],
              selectedIndex: _selectedIndex,
              onTabChange: (index) {
                setState(
                  () {
                    _selectedIndex = index;
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class HomeView extends StatelessWidget {
  const HomeView({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1.6 / 2,
      ),
      itemBuilder: (context, index) => Card(
        elevation: 0.0,
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: Color.fromARGB(
              255,
              Random().nextInt(255),
              Random().nextInt(255),
              Random().nextInt(255),
            ),
            width: 1.7,
          ),
          borderRadius: BorderRadius.circular(25),
        ),
        child: Container(
          padding: const EdgeInsets.all(8),
          child: Stack(
            children: [
              Image.asset("assests/4.png"),
              Align(
                alignment: Alignment.bottomCenter,
                child: ListTile(
                  tileColor: Colors.white,
                  title: Text(
                    "Wash Basin",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                  ),
                  subtitle: Text(
                    "499",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  trailing: Icon(Icons.shopping_cart),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
