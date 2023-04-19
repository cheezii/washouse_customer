import 'package:flutter/material.dart';
import 'package:washouse_customer/components/constants/color_constants.dart';
import 'package:washouse_customer/components/constants/text_constants.dart';

import '../../../resource/controller/order_controller.dart';
import '../../../resource/models/order.dart';
import '../../../resource/models/response_models/order_item_list.dart';
import 'no_order.dart';
import 'list_widgets/order_card.dart';

class OrderCompleteScreen extends StatefulWidget {
  const OrderCompleteScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<OrderCompleteScreen> createState() => _OrderCompleteScreenState();
}

class _OrderCompleteScreenState extends State<OrderCompleteScreen> {
  late OrderController orderController;
  List<Order_Item> orderListCompleted = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    orderController = OrderController(context);
    getOrderItems();
  }

  void getOrderItems() async {
    // Show loading indicator
    setState(() {
      isLoading = true;
    });

    try {
      // Wait for getOrderInformation to complete
      List<Order_Item> result = await orderController.getOrderList(1, 100, null, null, null, "completed", null);
      setState(() {
        // Update state with loaded data
        orderListCompleted = result;
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
    // int counter = 0;

    // for (var item in orderList) {
    //   if (item.status.compareTo('Hoàn tất') == 0) {
    //     counter++;
    //     orderListCompleted.add(item);
    //   }
    // }
    if (isLoading) {
      return CircularProgressIndicator();
    } else {
      if (orderListCompleted.isEmpty) {
        return const NoOrderScreen();
      } else {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: orderListCompleted.length,
              itemBuilder: ((context, index) {
                return OrderedCard(
                  orderItem: orderListCompleted[index],
                  statusColor: completeColor,
                  statusString: completed,
                  status: 'Hoàn tất',
                  // isComplete: true,
                  // isPending: false,
                  // isCancel: false,
                  // isProcessing: false,
                  // isShipping: false,
                );
              }),
            ),
          ),
        );
      }
    }
  }
}
