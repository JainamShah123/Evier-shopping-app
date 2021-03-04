// Flutter base Packages.
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Flutter Firebase Packages.
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

// Custom Widgets or Screens.
import './myapp.dart';

void main() async {
  // Initialising Firebase...
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // Injecting the User instance in all the application.
        StreamProvider<User>.value(
          initialData: null,
          value: FirebaseAuth.instance.authStateChanges(),
        ),
      ],
      child: MyApp(), // Main wrapper class for auth and init the MaterialApp()
    );
  }
}
