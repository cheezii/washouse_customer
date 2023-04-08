import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:washouse_customer/components/constants/color_constants.dart';
import 'package:washouse_customer/components/constants/text_constants.dart';
import 'package:washouse_customer/screens/order/component/confirmed_screen.dart';

import 'component/pending_screen.dart';
import 'component/processing_screen.dart';
import 'component/ready_screen.dart';
import 'order_history_screen.dart';
import 'search_order_screen.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 4,
      child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            automaticallyImplyLeading: false,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            title: const Text('Đơn hàng',
                style: TextStyle(
                    color: textColor,
                    fontSize: 30,
                    fontWeight: FontWeight.bold)),
            actions: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      PageTransition(
                          child: const SearchOrderScreen(),
                          type: PageTransitionType.fade));
                },
                child: const Padding(
                  padding: EdgeInsets.only(right: 16),
                  child: Icon(
                    Icons.search_rounded,
                    color: textColor,
                    size: 27,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      PageTransition(
                          child: const OrderHistoryScreen(),
                          type: PageTransitionType.rightToLeftWithFade));
                },
                child: const Text(
                  'Lịch sử',
                  style: TextStyle(fontSize: 18, color: kPrimaryColor),
                ),
              )
            ],
            bottom: const TabBar(
              unselectedLabelColor: textColor,
              labelColor: textColor,
              tabs: [
                Tab(text: pending),
                Tab(text: confirmed),
                Tab(text: processing),
                Tab(text: ready),
              ],
            ),
          ),
          body: const TabBarView(children: [
            OrderPedingScreen(),
            OrderConfirmedScreen(),
            OrderProcessingScreen(),
            OrderReadyScreen(),
          ])),
    );
  }
}
