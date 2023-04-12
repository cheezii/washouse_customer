import 'package:flutter/material.dart';
import 'package:washouse_customer/components/constants/color_constants.dart';
import 'package:washouse_customer/components/constants/text_constants.dart';

import '../../../resource/models/order.dart';
import '../../../resource/models/response_models/order_item_list.dart';
import 'no_order.dart';
import 'list_widgets/order_card.dart';

class OrderCompleteScreen extends StatelessWidget {
  List<Order_Item> orderListCompleted;
  OrderCompleteScreen(this.orderListCompleted, {super.key});

  @override
  Widget build(BuildContext context) {
    // int counter = 0;

    // for (var item in orderList) {
    //   if (item.status.compareTo('Hoàn tất') == 0) {
    //     counter++;
    //     orderListCompleted.add(item);
    //   }
    // }
    if (orderListCompleted.isEmpty) {
      return const NoOrderScreen();
    } else {
      return SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: orderListCompleted.length,
            itemBuilder: ((context, index) {
              return OrderedCard(
                orderItem: orderListCompleted[index],
                statusColor: completeColor,
                statusString: completed,
                status: 'Hoàn tất',
                isComplete: true,
                isPending: false,
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
