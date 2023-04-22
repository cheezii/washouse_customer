import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:washouse_customer/components/constants/color_constants.dart';
import 'package:washouse_customer/screens/home/base_screen.dart';

class OrderSuccessScreen extends StatelessWidget {
  const OrderSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
                height: 150,
                width: 150,
                child: Image.asset('assets/images/firework.png')),
            const SizedBox(height: 15),
            const Text(
              'Bạn đã đặt hàng thành công!',
              style: TextStyle(fontSize: 23, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 15),
            TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      PageTransition(
                          child: const BaseScreen(),
                          type: PageTransitionType.rightToLeftWithFade));
                },
                child: const Text(
                  'Quay lại trang chủ',
                  style: TextStyle(color: kPrimaryColor, fontSize: 18),
                ))
          ],
        ),
      ),
    );
  }
}
