import 'package:flutter/material.dart';
import 'package:washouse_customer/components/constants/color_constants.dart';
import 'package:washouse_customer/components/constants/text_constants.dart';
import 'package:washouse_customer/resource/models/response_models/order_item_list.dart';
import 'package:washouse_customer/screens/order/component/no_order.dart';

import '../../../resource/models/order.dart';
import 'list_widgets/order_card.dart';

class OrderConfirmedScreen extends StatelessWidget {
  List<Order_Item> orderListConfirmed;
  OrderConfirmedScreen(this.orderListConfirmed, {super.key});

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
    if (orderListConfirmed.isEmpty) {
      return const NoOrderScreen();
    } else {
      return SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: orderListConfirmed.length,
            itemBuilder: ((context, index) {
              return OrderedCard(
                orderItem: orderListConfirmed[index],
                statusColor: confirmedColor,
                statusString: confirmed,
                status: 'Xác nhận',
                // isComplete: false,
                // isPending: false,
                // isCancel: false,
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
