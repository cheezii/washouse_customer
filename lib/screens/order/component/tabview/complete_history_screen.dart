import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:washouse_customer/components/constants/color_constants.dart';
import 'package:washouse_customer/components/constants/text_constants.dart';

import '../../../../resource/controller/order_controller.dart';
import '../../../../resource/models/order.dart';
import '../../../../resource/models/response_models/order_item_list.dart';
import '../../../../utils/order_util.dart';
import '../no_order.dart';
import '../list_widgets/order_card.dart';

class OrderCompleteScreen extends StatefulWidget {
  final String? filter;
  const OrderCompleteScreen({
    required this.filter,
    Key? key,
  }) : super(key: key);

  @override
  State<OrderCompleteScreen> createState() => _OrderCompleteScreenState();
}

class _OrderCompleteScreenState extends State<OrderCompleteScreen> {
  late OrderController orderController;
  List<Order_Item> orderListCompleted = [];
  bool isLoading = false;
  String? filterString;

  @override
  void initState() {
    super.initState();
    orderController = OrderController(context);
    filterString = OrderUtils().getTextOfFilterOrderType(widget.filter);
  }

  void getOrderItems() async {
    // Show loading indicator
    setState(() {
      isLoading = true;
    });

    try {
      var filterString = OrderUtils().getTextOfFilterOrderType(widget.filter);
      // Wait for getOrderInformation to complete
      List<Order_Item> result = await orderController.getOrderList(1, 100, null, null, null, "completed", filterString);
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
    // if (isLoading) {
    //   return Center(
    //     child: LoadingAnimationWidget.prograssiveDots(color: kPrimaryColor, size: 50),
    //   );
    // } else {
    //   if (orderListCompleted.isEmpty) {
    //     return const NoOrderScreen();
    //   } else {
    //     return SingleChildScrollView(
    //       child: Padding(
    //         padding: const EdgeInsets.all(16),
    //         child: ListView.builder(
    //           shrinkWrap: true,
    //           physics: const NeverScrollableScrollPhysics(),
    //           itemCount: orderListCompleted.length,
    //           itemBuilder: ((context, index) {
    //             return OrderedCard(orderItem: orderListCompleted[index]);
    //           }),
    //         ),
    //       ),
    //     );
    //   }
    // }
    setState(() {
      filterString = OrderUtils().getTextOfFilterOrderType(widget.filter);
    });
    return FutureBuilder(
      future: orderController.getOrderList(1, 100, null, null, null, 'completed', filterString),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: LoadingAnimationWidget.prograssiveDots(color: kPrimaryColor, size: 50),
          );
        } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
          orderListCompleted = snapshot.data!;
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: orderListCompleted.length,
                itemBuilder: ((context, index) {
                  return OrderedCard(orderItem: orderListCompleted[index]);
                }),
              ),
            ),
          );
        } else {
          return const NoOrderScreen();
        }
      },
    );
  }
}
