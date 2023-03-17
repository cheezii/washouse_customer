import 'package:flutter/material.dart';
import 'package:washouse_customer/components/constants/color_constants.dart';
import 'package:washouse_customer/components/constants/text_constants.dart';

import '../../../models/order.dart';
import 'no_order.dart';
import 'list_widgets/order_card.dart';

class OrderCompleteScreen extends StatelessWidget {
  const OrderCompleteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    int counter = 0;
    List<Order> completeList = [];
    for (var item in orderList) {
      if (item.status == 4) {
        counter++;
        completeList.add(item);
      }
    }
    if (completeList.isEmpty) {
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
                statusColor: completeColor,
                statusString: complete,
                status: 4,
                isComplete: true,
                isConfirm: false,
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
