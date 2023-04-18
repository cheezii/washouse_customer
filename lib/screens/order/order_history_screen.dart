import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import '../../components/constants/color_constants.dart';
import '../../resource/controller/order_controller.dart';
import '../../resource/models/response_models/order_item_list.dart';
import 'component/cancel_history_screen.dart';
import 'component/complete_history_screen.dart';
import 'search_order_screen.dart';

class OrderHistoryScreen extends StatefulWidget {
  const OrderHistoryScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<OrderHistoryScreen> createState() => _OrderHistoryScreenState();
}

class _OrderHistoryScreenState extends State<OrderHistoryScreen> {
  late OrderController orderController;
  List<Order_Item> orderCompletedItems = [];
  List<Order_Item> orderCancelledItems = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    orderController = OrderController(context);
    // centerArgs = widget.orderId;
    getorderHistoryItems();
  }

  void getorderHistoryItems() async {
    // Show loading indicator
    setState(() {
      isLoading = true;
    });

    try {
      // Wait for getOrderInformation to complete
      List<Order_Item> completedResult = await orderController.getOrderList(
          1, 100, null, null, null, "completed", null);
      List<Order_Item> cancelledResult = await orderController.getOrderList(
          1, 100, null, null, null, "cancelled", null);

      setState(() {
        // Update state with loaded data
        orderCompletedItems = completedResult;
        orderCancelledItems = cancelledResult;
        isLoading = false;
      });
    } catch (e) {
      // Handle error
      setState(() {
        isLoading = false;
      });
      print('Error loading data: $e');
    }
  }

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
          centerTitle: true,
          title: const Text('Lịch sử giao dịch',
              style: TextStyle(color: textColor, fontSize: 27)),
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
        body: TabBarView(
          children: [
            OrderCompleteScreen(orderCompletedItems),
            OrderCancelScreen(orderCancelledItems),
          ],
        ),
      ),
    );
  }
}
