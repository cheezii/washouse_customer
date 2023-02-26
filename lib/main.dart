import 'package:flutter/material.dart';
import 'package:washouse_customer/screens/started/onboarding.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Washouse',
      home: Onboarding(),
      debugShowCheckedModeBanner: false,
    );
  }
}
