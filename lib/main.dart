import 'package:animal_app_flutter/pages/HomePage.dart';
import 'package:animal_app_flutter/pages/splashScreen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: 'intro_screen',
      routes: {
        'intro_screen': (context) => const IntroScreen(),
        '/': (context) => const HomePage(),
      },
    ),
  );
}
