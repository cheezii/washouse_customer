import 'package:flutter/material.dart';
import 'package:washouse_customer/screens/started/onboarding.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Washouse',
      home: SafeArea(child: Onboarding()),
      debugShowCheckedModeBanner: false,
    );
  }
}
