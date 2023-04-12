import 'package:flutter/material.dart';
import 'package:washouse_customer/components/constants/color_constants.dart';
import 'package:washouse_customer/components/constants/text_constants.dart';
import 'package:washouse_customer/resource/models/order.dart';
import 'package:washouse_customer/resource/models/response_models/order_item_list.dart';
import 'package:washouse_customer/screens/order/component/no_order.dart';

import 'list_widgets/order_card.dart';

class OrderProcessingScreen extends StatelessWidget {
  List<Order_Item> orderListProcessing;

  OrderProcessingScreen(this.orderListProcessing, {super.key});

  @override
  Widget build(BuildContext context) {
    int counter = 0;
    List<Order> processingList = [];
    for (var item in processingList) {
      if (item.status.compareTo('Xử lý') == 0) {
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
                orderItem: orderListProcessing[index],
                statusColor: processingColor,
                statusString: processing,
                status: 'Xử lý',
                isComplete: false,
                isPending: false,
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
