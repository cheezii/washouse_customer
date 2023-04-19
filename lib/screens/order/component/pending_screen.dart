import 'package:flutter/material.dart';
import 'package:washouse_customer/components/constants/color_constants.dart';
import 'package:washouse_customer/components/constants/text_constants.dart';
import 'package:washouse_customer/resource/controller/order_controller.dart';
import 'package:washouse_customer/resource/models/response_models/order_item_list.dart';
import 'package:washouse_customer/screens/order/component/no_order.dart';

import '../../../resource/models/order.dart';
import 'list_widgets/order_card.dart';

class OrderPedingScreen extends StatefulWidget {
  const OrderPedingScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<OrderPedingScreen> createState() => _OrderPedingScreenState();
}

class _OrderPedingScreenState extends State<OrderPedingScreen> {
  late OrderController orderController;
  List<Order_Item> list = [];
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
      List<Order_Item> result = await orderController.getOrderList(1, 100, null, null, null, "pending", null);
      setState(() {
        // Update state with loaded data
        list = result;
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
    // List<Order> confirmingList = [];
    // for (var item in orderList) {
    //   if (item.status.compareTo('Đang chờ') == 0) {
    //     counter++;
    //     confirmingList.add(item);
    //   }
    // }
    if (isLoading) {
      return CircularProgressIndicator();
    } else {
      if (list.isEmpty) {
        return const NoOrderScreen();
      } else {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: list.length,
              itemBuilder: ((context, index) {
                return OrderedCard(
                  orderItem: list[index],
                  statusColor: pendingdColor,
                  statusString: pending,
                  status: 'Đang chờ',
                  // isComplete: false,
                  // isPending: true,
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
