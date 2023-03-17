import 'package:flutter/material.dart';
import 'package:washouse_customer/components/constants/color_constants.dart';
import 'package:washouse_customer/components/constants/text_constants.dart';
import 'package:washouse_customer/models/order.dart';
import 'package:washouse_customer/screens/order/component/no_order.dart';

import 'list_widgets/order_card.dart';

class OrderProcessingScreen extends StatelessWidget {
  const OrderProcessingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    int counter = 0;
    List<Order> processingList = [];
    for (var item in orderList) {
      if (item.status == 2) {
        counter++;
        processingList.add(item);
      }
    }
    if (processingList.isEmpty) {
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
                statusColor: processingColor,
                statusString: processing,
                status: 2,
                isComplete: false,
                isConfirm: false,
                isCancel: false,
                isProcessing: true,
                isShipping: false,
              );
            }),
          ),
        ),
      );
    }
  }
}
