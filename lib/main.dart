import 'package:calendar_app/screens/content_screen.dart';
import 'package:calendar_app/screens/login_screen.dart';
import 'package:flutter/material.dart';

void main() {
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
            fontSize: 35,
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
      home: const ContentScreen(),
      //home: const LoginScreen(),
    );
  }
}
