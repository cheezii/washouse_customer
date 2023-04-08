// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'card_body.dart';
import 'card_footer.dart';
import 'card_heading.dart';

class OrderedCard extends StatelessWidget {
  final Color statusColor;
  final String statusString;
  final String status;
  final bool isComplete;
  final bool isPending;
  final bool isCancel;
  final bool isProcessing;
  final bool isShipping;
  const OrderedCard({
    Key? key,
    required this.statusColor,
    required this.statusString,
    required this.status,
    required this.isComplete,
    required this.isPending,
    required this.isCancel,
    required this.isProcessing,
    required this.isShipping,
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
              CardHeading(statusColor: statusColor, status: statusString),
              const SizedBox(height: 10),
              CardBody(status: status),
              const SizedBox(height: 20),
              CardFooter(
                isComplete: isComplete,
                isPending: isPending,
                isCancel: isCancel,
                isProcessing: isProcessing,
                isShipping: isShipping,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
