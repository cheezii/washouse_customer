import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:washouse_customer/components/constants/color_constants.dart';
import 'package:washouse_customer/components/constants/text_constants.dart';

import '../../../../resource/controller/order_controller.dart';
import '../../../../resource/models/order.dart';
import '../../../../resource/models/response_models/order_item_list.dart';
import '../list_widgets/order_card.dart';
import '../no_order.dart';

class OrderCancelScreen extends StatefulWidget {
  const OrderCancelScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<OrderCancelScreen> createState() => _OrderCancelScreenState();
}

class _OrderCancelScreenState extends State<OrderCancelScreen> {
  late OrderController orderController;
  List<Order_Item> orderListCancelled = [];
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
      List<Order_Item> result = await orderController.getOrderList(
          1, 100, null, null, null, "cancelled", null);
      setState(() {
        // Update state with loaded data
        orderListCancelled = result;
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
    // List<Order> cancelList = [];
    // for (var item in orderList) {
    //   if (item.status.compareTo('Đã hủy') == 0) {
    //     counter++;
    //     cancelList.add(item);
    //   }
    // }
    if (isLoading) {
      return CircularProgressIndicator();
    } else {
      if (orderListCancelled.isEmpty) {
        return Center(
          child: LoadingAnimationWidget.prograssiveDots(
              color: kPrimaryColor, size: 50),
        );
      } else {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: orderListCancelled.length,
              itemBuilder: ((context, index) {
                return OrderedCard(orderItem: orderListCancelled[index]);
              }),
            ),
          ),
        );
      }
    }
  }
}
