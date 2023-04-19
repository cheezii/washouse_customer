import 'package:flutter/material.dart';
import 'package:washouse_customer/components/constants/color_constants.dart';
import 'package:washouse_customer/components/constants/text_constants.dart';
import 'package:washouse_customer/resource/models/order.dart';
import 'package:washouse_customer/resource/models/response_models/order_item_list.dart';
import 'package:washouse_customer/screens/order/component/no_order.dart';

import '../../../resource/controller/order_controller.dart';
import 'list_widgets/order_card.dart';

class OrderProcessingScreen extends StatefulWidget {
  const OrderProcessingScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<OrderProcessingScreen> createState() => _OrderProcessingScreenState();
}

class _OrderProcessingScreenState extends State<OrderProcessingScreen> {
  late OrderController orderController;
  List<Order_Item> orderListProcessing = [];
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
      List<Order_Item> result = await orderController.getOrderList(1, 100, null, null, null, "processing", null);
      setState(() {
        // Update state with loaded data
        orderListProcessing = result;
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
    // List<Order> processingList = [];
    // for (var item in processingList) {
    //   if (item.status.compareTo('Xử lý') == 0) {
    //     counter++;
    //     processingList.add(item);
    //   }
    // }
    if (isLoading) {
      return CircularProgressIndicator();
    } else {
      if (orderListProcessing.isEmpty) {
        return const NoOrderScreen();
      } else {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: orderListProcessing.length,
              itemBuilder: ((context, index) {
                return OrderedCard(
                  orderItem: orderListProcessing[index],
                  statusColor: processingColor,
                  statusString: processing,
                  status: 'Xử lý',
                  // isComplete: false,
                  // isPending: false,
                  // isCancel: false,
                  // isProcessing: true,
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
