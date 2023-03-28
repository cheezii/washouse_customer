import 'package:flutter/material.dart';
import 'package:washouse_customer/components/constants/color_constants.dart';
import 'package:washouse_customer/components/constants/text_constants.dart';
import 'package:washouse_customer/screens/order/component/no_order.dart';

import '../../../resource/models/order.dart';
import 'list_widgets/order_card.dart';

class OrderShippingScreen extends StatelessWidget {
  const OrderShippingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    int counter = 0;
    List<Order> shippingList = [];
    for (var item in orderList) {
      if (item.status == 3) {
        counter++;
        shippingList.add(item);
      }
    }
    if (shippingList.isEmpty) {
      return const NoOrderScreen();
    } else {
      return SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: counter,
            itemBuilder: ((context, index) {
              return OrderedCard(
                statusColor: shippingColor,
                statusString: shipping,
                status: 2,
                isComplete: false,
                isConfirm: false,
                isCancel: false,
                isProcessing: false,
                isShipping: true,
              );
            }),
          ),
        ),
      );
    }
  }
}
