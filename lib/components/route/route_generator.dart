import 'package:flutter/material.dart';
import 'package:washouse_customer/screens/cart/cart_screen.dart';
import 'package:washouse_customer/screens/center/center_details_screen.dart';
import 'package:washouse_customer/screens/center/service/service_detail_screen.dart';
import 'package:washouse_customer/screens/reset_password/send_otp.dart';

import '../../screens/notification/list_notification_screen.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case '/centerDetails':
        return MaterialPageRoute(
          builder: (context) => CenterDetailScreen(centerData: args),
        );
      case '/serviceDetails':
        return MaterialPageRoute(
          builder: (context) {
            final arrguments = settings.arguments as ScreenArguments;
            return ServiceDetailScreen(centerData: arrguments.screen1, serviceData: arrguments.screen2);
            // return ServiceDetailScreen(serviceData: args);
          },
        );
      case '/cart':
        return MaterialPageRoute(
          //builder: (context) => CartScreen(centerName: args),
          builder: (context) => CartScreen(),
        );
      case '/listNotification':
        return MaterialPageRoute(
          builder: (context) => ListNotificationScreen(),
        );
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (context) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('ERROR'),
          centerTitle: true,
        ),
        body: const Center(
          child: Text('Không tìm thấy trang!'),
        ),
      );
    });
  }
}

class ScreenArguments {
  final screen1;
  final screen2;

  ScreenArguments(this.screen1, this.screen2);
}
