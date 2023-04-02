import 'package:flutter/material.dart';
import 'package:washouse_customer/screens/center/center_details_screen.dart';
import 'package:washouse_customer/screens/center/service/service_detail_screen.dart';

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
          builder: (context) => ServiceDetailScreen(serviceData: args),
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
          title: Text('ERROR'),
          centerTitle: true,
        ),
        body: Center(
          child: Text('Không tìm thấy trang!'),
        ),
      );
    });
  }
}
