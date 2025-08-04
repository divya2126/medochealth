import 'package:day02/buffer.dart';
import 'package:day02/flutter.dart';
import 'package:day02/medoc.dart';
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
      initialRoute: 'home',
      routes: {
        "home": (context) => HomePage(),
       
        "Second": (context) => SecondScreen(),
       'buffer': (context) => const MyBuffer(),

        },
    );
  }
}