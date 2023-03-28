// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../../../../components/constants/color_constants.dart';
import '../../../../resource/models/order.dart';

class CardBody extends StatelessWidget {
  final int status;
  const CardBody({
    Key? key,
    required this.status,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Order> list = [];
    for (var item in orderList) {
      if (item.status == status) {
        list.add(item);
      }
    }
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
              child: Image.asset('assets/images/category/tie.png'),
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
                  list[0].serviceName,
                  style: const TextStyle(
                      fontSize: 17,
                      color: Colors.black,
                      fontWeight: FontWeight.w500),
                  maxLines: 2,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Text(
                    'SL: x${list[0].quantity}',
                    style: const TextStyle(color: textColor, fontSize: 16),
                  ),
                  const Text('  |  '),
                  const Text(
                    '80000 đ',
                    style: TextStyle(
                      fontSize: 16,
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
