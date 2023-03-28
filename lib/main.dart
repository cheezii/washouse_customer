import 'dart:io';

import 'package:flutter/material.dart';
import 'package:washouse_customer/screens/started/onboarding.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    HttpOverrides.global = MyHttpOverrides();
    return const MaterialApp(
      title: 'Washouse',
      home: SafeArea(child: Onboarding()),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
