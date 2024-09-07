import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:minimal_socialmedia/auth/auth.dart';
import 'package:minimal_socialmedia/firebase_options.dart';
import 'package:minimal_socialmedia/pages/home_page.dart';
import 'package:minimal_socialmedia/pages/profile_page.dart';
import 'package:minimal_socialmedia/pages/user_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AuthPage(),
      routes: {
        "/home_page": (context) => HomePage(),
        "/profile_page": (context) => ProfilePage(),
        "/user_page": (context) => const UserPage(),
      },
    );
  }
}
