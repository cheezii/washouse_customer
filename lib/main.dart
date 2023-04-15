// @dart=2.17
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:washouse_customer/components/route/route_generator.dart';
import 'package:washouse_customer/resource/controller/base_controller.dart';
import 'package:washouse_customer/resource/controller/cart_provider.dart';
import 'package:washouse_customer/screens/started/onboarding.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'screens/started/login.dart';

void main() async {
  runApp(
    ChangeNotifierProvider(
      create: (context) => CartProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Future<String> getAccessToken() => BaseController().getAccessToken();
  Future<bool> isAccess() => BaseController().getBooltoSharedPreference('isAccess');
  @override
  Widget build(BuildContext context) {
    HttpOverrides.global = MyHttpOverrides();
    return MaterialApp(
      title: 'Washouse',
      initialRoute: '/',
      onGenerateRoute: RouteGenerator.generateRoute,
      //home: SafeArea(child: Onboarding()),
      // home: FutureBuilder(
      //     future: getAccessToken(),
      //     builder: (context, snapshot) {
      //       switch (snapshot.connectionState) {
      //         case ConnectionState.waiting:
      //           return Container(
      //             color: Colors.white,
      //             child: Center(child: CircularProgressIndicator()),
      //           );
      //         case ConnectionState.active:
      //         case ConnectionState.done:
      //           if (snapshot.hasData) {
      //             return (snapshot.data == null)
      //                 ? SafeArea(child: Onboarding())
      //                 : Login();
      //           }
      //           return SafeArea(child: Onboarding()); // error view
      //         default:
      //           return SafeArea(child: Onboarding()); // error view
      //       }
      //     }),
      home: FutureBuilder(
          future: isAccess(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return Container(
                  color: Colors.white,
                  child: Center(child: CircularProgressIndicator()),
                );
              case ConnectionState.active:
              case ConnectionState.done:
                if (snapshot.hasData) {
                  return (snapshot.data == false) ? SafeArea(child: Onboarding()) : Login();
                }
                return SafeArea(child: Onboarding()); // error view
              default:
                return SafeArea(child: Onboarding()); // error view
            }
          }),
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        //Locale('en', 'US'),
        Locale('vi', 'VN'),
      ],
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}
