import 'package:flutter/material.dart';
import 'package:washouse_customer/components/constants/color_constants.dart';
import 'package:washouse_customer/resource/models/response_models/order_item_list.dart';

import '../../../../resource/models/order.dart';

class CardHeading extends StatelessWidget {
  Order_Item orderItem;
  CardHeading({super.key, required this.orderItem});

  @override
  Widget build(BuildContext context) {
    String statusOrder = orderItem.status!.toLowerCase();
    String status = '';
    Color statusColor = kPrimaryColor;
    if (statusOrder == 'pending') {
      statusColor = pendingdColor;
      status = 'Đang chờ';
    } else if (statusOrder == 'confirmed') {
      statusColor = confirmedColor;
      status = 'Xác nhận';
    } else if (statusOrder == 'received') {
      statusColor = receivedColor;
      status = 'Đã nhận';
    } else if (statusOrder == 'processing') {
      statusColor = processingColor;
      status = 'Xử lý';
    } else if (statusOrder == 'ready') {
      statusColor = readyColor;
      status = 'Sẵn sàng';
    } else if (statusOrder == 'completed') {
      statusColor = completeColor;
      status = 'Hoàn tất';
    } else if (statusOrder == 'cancelled') {
      statusColor = cancelledColor;
      status = 'Đã hủy';
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Row(
            children: [
              const Icon(
                Icons.local_laundry_service_rounded,
                color: kPrimaryColor,
                size: 26,
              ),
              const SizedBox(width: 4),
              Expanded(
                child: Text(
                  orderItem.centerName!,
                  style: const TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.w700,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
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
