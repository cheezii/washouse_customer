import 'package:flutter/material.dart';
import 'package:washouse_customer/components/constants/color_constants.dart';

import '../../../../models/order.dart';

class CardHeading extends StatelessWidget {
  const CardHeading({
    super.key,
    required this.statusColor,
    required this.status,
  });

  final Color statusColor;
  final String status;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            const Icon(
              Icons.local_laundry_service_rounded,
              color: kPrimaryColor,
              size: 26,
            ),
            const SizedBox(width: 4),
            Text(
              orderList[0].centerName,
              style: const TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        Container(
          decoration: BoxDecoration(
            color: statusColor,
            border: Border.all(color: statusColor),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              status,
              style: const TextStyle(fontSize: 15, color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}
