import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import 'firebase_options.dart';
import 'package:calendar_app/screens/auth_screen.dart';
//import 'package:calendar_app/screens/chat.dart';
import 'package:calendar_app/screens/splash.dart';
import 'package:calendar_app/screens/calendar/content_screen.dart';

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
      debugShowCheckedModeBanner: false,
      title: 'Flutter Calendar',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: const TextTheme(
          titleLarge: TextStyle(
            fontSize: 31,
            fontWeight: FontWeight.bold,
          ),
          titleMedium: TextStyle(
            fontSize: 16,
          ),
          titleSmall: TextStyle(
            fontSize: 12,
          ),
        ),
      ),
      home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (ctx, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const SplashScreen();
            }

            if (snapshot.hasData) {
              //return const ChatScreen();
              return const ContentScreen();
            }

            return const AuthScreen();
          }),
    );
  }
}
