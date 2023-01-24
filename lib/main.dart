// ignore_for_file: deprecated_member_use

import 'package:chat_app/screens/auth_screen.dart';
import 'package:chat_app/screens/chat_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';

import 'screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final Future<FirebaseApp> initialization = Firebase.initializeApp();

    return FutureBuilder(
        future: initialization,
        builder: (context, snapshot) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Chat',
            theme: ThemeData(
              backgroundColor: Colors.cyanAccent,
              primarySwatch: Colors.cyan,
              accentColor: const Color.fromARGB(255, 96, 187, 247),
              accentColorBrightness: Brightness.dark,
              buttonTheme: ButtonTheme.of(context).copyWith(
                  buttonColor: Colors.cyan,
                  textTheme: ButtonTextTheme.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  )),
            ),
            home: StreamBuilder(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (context, userSnapShot) {
                if (userSnapShot.connectionState == ConnectionState.waiting) {
                  return const SplashScreen();
                }
                if (userSnapShot.hasData) {
                  return const ChatScreen();
                }
                return const AuthScreen();
              },
            ),
          );
        });
  }
}
