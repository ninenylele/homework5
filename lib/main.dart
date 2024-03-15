import 'package:flutter/material.dart';
import 'package:homework5/pages/home/home_page.dart';
//import 'package:homework5/pages/pin_login/pin_login_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PRESIDENTS',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Color.fromARGB(255, 10, 10, 10),
        ),
        useMaterial3: true,
        backgroundColor: const Color.fromARGB(255, 8, 8, 8),
      ),
      home: HomePage(), // Remove the 'const' keyword here
    );
  }
}
