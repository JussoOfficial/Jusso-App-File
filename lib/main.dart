import 'package:flutter/material.dart';
import 'package:jusso_o/splash%20screen/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.deepOrange,
        // Define light theme colors and styles
        primaryColor: Colors.deepOrange,
        hintColor: Colors.deepOrangeAccent,
        scaffoldBackgroundColor: Colors.white,
        textTheme: const TextTheme(
          displayLarge: TextStyle(
              fontSize: 24.0, fontWeight: FontWeight.bold, color: Colors.black),
          bodyLarge: TextStyle(fontSize: 14.0, color: Colors.black87),
        ),
        // Other theme properties...
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.deepOrange,
        // Define dark theme colors and styles
        primaryColor: Colors.deepOrange,
        hintColor: Colors.deepOrangeAccent,
        scaffoldBackgroundColor: Colors.black,
        textTheme: const TextTheme(
          displayLarge: TextStyle(
              fontSize: 24.0, fontWeight: FontWeight.bold, color: Colors.white),
          bodyLarge: TextStyle(fontSize: 14.0, color: Colors.white70),
        ),
        // Other theme properties...
      ),
      themeMode: ThemeMode.system, // Automatically switch based on system theme
      home: SplashScreen(),
    );
  }
}
