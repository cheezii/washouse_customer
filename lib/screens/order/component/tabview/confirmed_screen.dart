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

class OrderConfirmedScreen extends StatefulWidget {
  final String? filter;
  const OrderConfirmedScreen({
    required this.filter,
    Key? key,
  }) : super(key: key);

  @override
  State<OrderConfirmedScreen> createState() => _OrderConfirmedScreenState();
}

class _OrderConfirmedScreenState extends State<OrderConfirmedScreen> {
  late OrderController orderController;
  List<Order_Item> orderListConfirmed = [];
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
      List<Order_Item> result = await orderController.getOrderList(
          1, 100, null, null, null, "confirmed", filterString);
      setState(() {
        // Update state with loaded data
        orderListConfirmed = result;
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
    //   if (item.status.compareTo('Xác nhận') == 0) {
    //     counter++;
    //     confirmingList.add(item);
    //   }
    // }
    // if (isLoading) {
    //   return Center(
    //     child: LoadingAnimationWidget.prograssiveDots(
    //         color: kPrimaryColor, size: 50),
    //   );
    // } else {
    //   if (orderListConfirmed.isEmpty) {
    //     return const NoOrderScreen();
    //   } else {
    //     return SingleChildScrollView(
    //       child: Padding(
    //         padding: const EdgeInsets.all(16),
    //         child: ListView.builder(
    //           shrinkWrap: true,
    //           physics: const NeverScrollableScrollPhysics(),
    //           itemCount: orderListConfirmed.length,
    //           itemBuilder: ((context, index) {
    //             return OrderedCard(orderItem: orderListConfirmed[index]);
    //           }),
    //         ),
    //       ),
    //     );
    //   }
    // }
    return FutureBuilder(
      future: orderController.getOrderList(
          1, 100, null, null, null, 'confirmed', filterString),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: LoadingAnimationWidget.prograssiveDots(
                color: kPrimaryColor, size: 50),
          );
        } else if (snapshot.hasData) {
          orderListConfirmed = snapshot.data!;
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: orderListConfirmed.length,
                itemBuilder: ((context, index) {
                  return OrderedCard(orderItem: orderListConfirmed[index]);
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
