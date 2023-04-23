import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:washouse_customer/components/constants/color_constants.dart';
import 'package:washouse_customer/components/constants/text_constants.dart';
import 'package:washouse_customer/resource/models/response_models/order_item_list.dart';
import 'package:washouse_customer/screens/order/component/no_order.dart';

import '../../../../resource/controller/order_controller.dart';
import '../../../../resource/models/order.dart';
import '../../../../utils/order_util.dart';
import '../list_widgets/order_card.dart';

class OrderReadyScreen extends StatefulWidget {
  final String? filter;
  const OrderReadyScreen({
    required this.filter,
    Key? key,
  }) : super(key: key);

  @override
  State<OrderReadyScreen> createState() => _OrderReadyScreenState();
}

class _OrderReadyScreenState extends State<OrderReadyScreen> {
  late OrderController orderController;
  List<Order_Item> orderListReady = [];
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
      // Wait for getOrderInformation to complete
      var filterString = OrderUtils().getTextOfFilterOrderType(widget.filter);
      // Wait for getOrderInformation to complete
      List<Order_Item> result = await orderController.getOrderList(1, 100, null, null, null, "ready", filterString);
      setState(() {
        // Update state with loaded data
        orderListReady = result;
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
    // List<Order> shippingList = [];
    // for (var item in orderList) {
    //   if (item.status.compareTo('Sẵn sàng') == 0) {
    //     counter++;
    //     shippingList.add(item);
    //   }
    // }
    // if (isLoading) {
    //   return Center(
    //     child: LoadingAnimationWidget.prograssiveDots(color: kPrimaryColor, size: 50),
    //   );
    // } else {
    //   if (orderListReady.isEmpty) {
    //     return const NoOrderScreen();
    //   } else {
    //     return SingleChildScrollView(
    //       child: Padding(
    //         padding: const EdgeInsets.all(16),
    //         child: ListView.builder(
    //           shrinkWrap: true,
    //           physics: const NeverScrollableScrollPhysics(),
    //           itemCount: orderListReady.length,
    //           itemBuilder: ((context, index) {
    //             return OrderedCard(
    //               orderItem: orderListReady[index],
    //             );
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
      future: orderController.getOrderList(1, 100, null, null, null, 'ready', filterString),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: LoadingAnimationWidget.prograssiveDots(color: kPrimaryColor, size: 50),
          );
        } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
          orderListReady = snapshot.data!;
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: orderListReady.length,
                itemBuilder: ((context, index) {
                  return OrderedCard(orderItem: orderListReady[index]);
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
