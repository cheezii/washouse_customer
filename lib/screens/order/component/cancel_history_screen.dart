import 'package:flutter/material.dart';
import 'package:washouse_customer/components/constants/color_constants.dart';
import 'package:washouse_customer/components/constants/text_constants.dart';

import '../../../resource/models/order.dart';
import '../../../resource/models/response_models/order_item_list.dart';
import 'list_widgets/order_card.dart';
import 'no_order.dart';

class OrderCancelScreen extends StatelessWidget {
  List<Order_Item> orderListCancelled;
  OrderCancelScreen(this.orderListCancelled, {super.key});

  @override
  Widget build(BuildContext context) {
    // int counter = 0;
    // List<Order> cancelList = [];
    // for (var item in orderList) {
    //   if (item.status.compareTo('Đã hủy') == 0) {
    //     counter++;
    //     cancelList.add(item);
    //   }
    // }
    if (orderListCancelled.isEmpty) {
      return const NoOrderScreen();
    } else {
      return SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: orderListCancelled.length,
            itemBuilder: ((context, index) {
              return OrderedCard(
                orderItem: orderListCancelled[index],
                statusColor: cancelColor,
                statusString: canceled,
                status: 'Đã hủy',
                // isComplete: false,
                // isPending: false,
                // isCancel: true,
                // isProcessing: false,
                // isShipping: false,
              );
            }),
          ),
        ),
      );
    }
  }
}
