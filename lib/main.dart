// @dart=2.17
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:washouse_customer/components/route/route_generator.dart';
import 'package:washouse_customer/resource/controller/cart_provider.dart';
import 'package:washouse_customer/screens/cart/cart_screen.dart';
import 'package:washouse_customer/screens/center/center_details_screen.dart';
import 'package:washouse_customer/screens/started/onboarding.dart';

import 'screens/center/service/service_detail_screen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => CartProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    HttpOverrides.global = MyHttpOverrides();
    return const MaterialApp(
      title: 'Washouse',
      initialRoute: '/',
      onGenerateRoute: RouteGenerator.generateRoute,
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
