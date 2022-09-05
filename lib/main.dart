import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import './myapp.dart';
import './database/database.dart';
import './authentication/auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
<<<<<<< HEAD
  await Firebase.initializeApp();
=======
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: "AIzaSyA0A04dO-645GkmhnbZQvpvhn5qLODF0aI",
      authDomain: "evier-shopping-system.firebaseapp.com",
      projectId: "evier-shopping-system",
      storageBucket: "evier-shopping-system.appspot.com",
      messagingSenderId: "198875778892",
      appId: "1:198875778892:web:d563b8682f912e08c609e9",
      measurementId: "G-BQB9530LZD",
    ),
  );

>>>>>>> f7d45b19067c14f255d703a1e9d5b5dcc3321376
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => Auth(),
        ),
        ChangeNotifierProvider<DatabaseServices?>(
          create: (context) => DatabaseServices(),
        ),
        StreamProvider<User?>.value(
          value: FirebaseAuth.instance.authStateChanges(),
          initialData: null,
        ),
<<<<<<< HEAD
=======

        // ProxyProvider<UserData?,bool>(update: ,create: ,),
>>>>>>> f7d45b19067c14f255d703a1e9d5b5dcc3321376
      ],
      child: MyApp(),
    );
  }
}
