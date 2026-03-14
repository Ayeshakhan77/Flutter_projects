import 'package:flutter/material.dart';
import 'login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Modern Shop",
      theme: ThemeData(
        fontFamily: "Poppins",
      ),
      home: const LoginScreen(),
    );
  }
}
