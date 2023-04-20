// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:washouse_customer/resource/models/response_models/order_item_list.dart';

import 'card_body.dart';
import 'card_footer.dart';
import 'card_heading.dart';

class OrderedCard extends StatelessWidget {
  final Order_Item orderItem;
  const OrderedCard({
    Key? key,
    required this.orderItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 230,
      width: double.infinity,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CardHeading(
                orderItem: orderItem,
              ),
              const SizedBox(height: 10),
              CardBody(orderItem: orderItem),
              const SizedBox(height: 20),
              CardFooter(
                orderItem: orderItem,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
