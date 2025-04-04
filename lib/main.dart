import 'package:e__commerce/Features/auth/Views/LoginView.dart';
import 'package:e__commerce/Features/auth/Views/SIgnUpView.dart';
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
      home: SignUpView(),
    );
  }
}