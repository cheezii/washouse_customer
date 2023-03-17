import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import '../../components/constants/color_constants.dart';
import 'component/cancel_history_screen.dart';
import 'component/complete_history_screen.dart';
import 'search_order_screen.dart';

class OrderHistoryScreen extends StatelessWidget {
  const OrderHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: textColor,
              size: 24,
            ),
          ),
          title: const Align(
            alignment: Alignment.center,
            child: Text('Lịch sử giao dịch',
                style: TextStyle(color: textColor, fontSize: 27)),
          ),
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
                  size: 30,
                ),
              ),
            ),
          ],
          bottom: const TabBar(
            unselectedLabelColor: textColor,
            labelColor: textColor,
            tabs: [Tab(text: 'Đã hoàn thành'), Tab(text: 'Đã hủy')],
          ),
        ),
        body: const TabBarView(
          children: [
            OrderCompleteScreen(),
            OrderCancelScreen(),
          ],
        ),
      ),
    );
  }
}
