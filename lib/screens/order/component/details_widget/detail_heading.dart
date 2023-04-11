// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class DetailHeading extends StatelessWidget {
  const DetailHeading({
    Key? key,
    required this.statusColor,
    required this.status,
  }) : super(key: key);

  final Color statusColor;
  final String status;

  @override
  Widget build(BuildContext context) {
    return Text(
      status,
      style: TextStyle(color: statusColor, fontSize: 17, fontWeight: FontWeight.w600),
    );
  }
}
