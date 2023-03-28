import 'package:flutter/material.dart';
import 'package:washouse_customer/components/constants/color_constants.dart';
import 'package:washouse_customer/components/constants/text_constants.dart';

import '../../../resource/models/order.dart';
import 'list_widgets/order_card.dart';
import 'no_order.dart';

class OrderCancelScreen extends StatelessWidget {
  const OrderCancelScreen({super.key});

  @override
  Widget build(BuildContext context) {
    int counter = 0;
    List<Order> cancelList = [];
    for (var item in orderList) {
      if (item.status == 0) {
        counter++;
        cancelList.add(item);
      }
    }
    if (cancelList.isEmpty) {
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
                statusColor: cancelColor,
                statusString: cancel,
                status: 0,
                isComplete: false,
                isConfirm: false,
                isCancel: true,
                isProcessing: false,
                isShipping: false,
              );
            }),
          ),
        ),
      );
    }
  }
}
