// @dart=2.17
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:washouse_customer/resource/provider/notify_provider.dart';
import 'package:washouse_customer/components/route/route_generator.dart';
import 'package:washouse_customer/resource/controller/base_controller.dart';
import 'package:washouse_customer/resource/provider/cart_provider.dart';
import 'package:washouse_customer/screens/started/onboarding.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'resource/provider/chat_provider.dart';
import 'screens/started/login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  runApp(
    MyApp(prefs: prefs),
  );
}

class MyApp extends StatelessWidget {
  final SharedPreferences prefs;
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseStorage firebaseStorage = FirebaseStorage.instance;
  MyApp({required this.prefs});

  Future<String> getAccessToken() => BaseController().getAccessToken();
  Future<bool> isAccess() => BaseController().getBooltoSharedPreference('isAccess');
  @override
  Widget build(BuildContext context) {
    HttpOverrides.global = MyHttpOverrides();
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<CartProvider>(
          create: (context) => CartProvider(),
        ),
        Provider<ChatProvider>(
          create: (_) => ChatProvider(
            prefs: prefs,
            firebaseFirestore: firebaseFirestore,
            firebaseStorage: firebaseStorage,
          ),
        ),
      ],
      child: MaterialApp(
        title: 'Washouse',
        initialRoute: '/',
        onGenerateRoute: RouteGenerator.generateRoute,
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
      ),
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}
