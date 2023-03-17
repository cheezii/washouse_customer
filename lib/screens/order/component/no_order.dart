import 'package:flutter/material.dart';
import 'package:washouse_customer/components/constants/color_constants.dart';

class NoOrderScreen extends StatelessWidget {
  const NoOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(height: 40),
        Container(
          height: 150,
          width: 150,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: const Color(0xffD4DEFE),
            borderRadius: BorderRadius.circular(100),
          ),
          child: Image.asset('assets/images/order/no order.png'),
        ),
        const SizedBox(height: 15),
        const Text(
          'Không có giao dịch nào',
          style: TextStyle(fontSize: 20, color: Colors.black),
        ),
      ],
    );
  }
}
