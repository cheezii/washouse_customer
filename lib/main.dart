// @dart=2.17
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:washouse_customer/screens/center/center_details_screen.dart';
import 'package:washouse_customer/screens/started/onboarding.dart';

import 'screens/center/service/service_detail_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    HttpOverrides.global = MyHttpOverrides();
    return MaterialApp(
      title: 'Washouse',
      initialRoute: '/',
      routes: {
        '/centerDetails': (context) => const CenterDetailScreen(),
        '/serviceDetails': (context) => const ServiceDetailScreen(),
      },
      home: const SafeArea(child: Onboarding()),
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
