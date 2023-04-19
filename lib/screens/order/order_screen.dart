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

class OrderScreen extends StatefulWidget {
  const OrderScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  //late OrderController orderController;
  //List<Order_Item> orderItems = [];
  //bool isLoading = false;

  @override
  void initState() {
    super.initState();
    //orderController = OrderController(context);
    // centerArgs = widget.orderId;
    //getOrderItems();
  }

  // void getOrderItems() async {
  //   // Show loading indicator
  //   setState(() {
  //     isLoading = true;
  //   });

  //   try {
  //     // Wait for getOrderInformation to complete
  //     List<Order_Item> result = await orderController.getOrderList(1, 100, null, null, null, "pending", null);
  //     setState(() {
  //       // Update state with loaded data
  //       orderItems = result;
  //       isLoading = false;
  //     });
  //   } catch (e) {
  //     // Handle error
  //     setState(() {
  //       isLoading = false;
  //     });
  //     print('Error loading data: $e');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    //var orderListPending = orderItems.where((element) => element.status!.toLowerCase().compareTo('pending') == 0).toList();
    //var orderListConfirmed = orderItems.where((element) => element.status!.toLowerCase().compareTo('confirmed') == 0).toList();
    //var orderListProcessing = orderItems.where((element) => element.status!.toLowerCase().compareTo('processing') == 0).toList();
    //print('processing-${orderListProcessing.length}');
    //var orderListReady = orderItems.where((element) => element.status!.toLowerCase().compareTo('ready') == 0).toList();
    return DefaultTabController(
      initialIndex: 0,
      length: 4,
      child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            automaticallyImplyLeading: false,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            title: const Text('Đơn hàng', style: TextStyle(color: textColor, fontSize: 30, fontWeight: FontWeight.bold)),
            actions: [
              GestureDetector(
                onTap: () {
                  Navigator.push(context, PageTransition(child: const SearchOrderScreen(), type: PageTransitionType.fade));
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
                  Navigator.push(context, PageTransition(child: const OrderHistoryScreen(), type: PageTransitionType.rightToLeftWithFade));
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
