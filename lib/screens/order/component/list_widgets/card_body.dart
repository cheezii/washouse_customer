// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:washouse_customer/resource/models/response_models/order_item_list.dart';

import '../../../../components/constants/color_constants.dart';
import '../../../../resource/models/order.dart';
import '../../../../utils/price_util.dart';

class CardBody extends StatelessWidget {
  final String status;
  Order_Item orderItem;
  CardBody({
    Key? key,
    required this.status,
    required this.orderItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // List<Order> list = [];
    // for (var item in orderList) {
    //   if (item.status.compareTo(status) == 0) {
    //     list.add(item);
    //   }
    // }
    return Row(
      children: [
        SizedBox(
          width: 70,
          child: AspectRatio(
            aspectRatio: 0.88,
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: const Color(0xfff5f6f9),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Image.asset('assets/images/category/shirt.png'),
              //child: Image.network(orderItem.orderedServices!.first.image!),
            ),
          ),
        ),
        const SizedBox(width: 20),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 200,
                child: Text(
                  orderItem.orderedServices!.first.serviceName!,
                  style: const TextStyle(fontSize: 17, color: Colors.black, fontWeight: FontWeight.w500),
                  maxLines: 2,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Text(
                    orderItem.orderedServices!.first.unit == 'Kg' ? 'KL: x${orderItem.orderedServices!.first.measurement} kg' : 'SL: x${orderItem.orderedServices!.first.measurement}',
                    style: const TextStyle(color: textColor, fontSize: 16),
                  ),
                  const Text('  |  '),
                  Text(
                    '${PriceUtils().convertFormatPrice((orderItem.orderedServices!.first.price!).round())} đ',
                    style: const TextStyle(
                      fontSize: 16,
                      color: kPrimaryColor,
                      fontWeight: FontWeight.w500
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
