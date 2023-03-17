import 'package:flutter/material.dart';
import 'package:washouse_customer/components/constants/color_constants.dart';
import 'package:washouse_customer/components/constants/text_constants.dart';
import 'package:washouse_customer/screens/order/component/no_order.dart';

import '../../../models/order.dart';
import 'list_widgets/order_card.dart';

class OrderConfirmingScreen extends StatelessWidget {
  const OrderConfirmingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    int counter = 0;
    List<Order> confirmingList = [];
    for (var item in orderList) {
      if (item.status == 1) {
        counter++;
        confirmingList.add(item);
      }
    }
    if (confirmingList.isEmpty) {
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
                statusColor: confirmingColor,
                statusString: confirming,
                status: 0,
                isComplete: false,
                isConfirm: true,
                isCancel: false,
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
