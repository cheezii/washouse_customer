import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:page_transition/page_transition.dart';

import '../../../../components/constants/color_constants.dart';
import '../../../../resource/models/cart.dart';
import '../../checkout_screen.dart';

class OrderCard extends StatelessWidget {
  const OrderCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    double total = 0.0;
    // for (int i = 0; i < demoCarts.length; i++) {
    //   total += demoCarts[i].numOfItems.value * demoCarts[i].service.price;
    // }
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
      height: 174,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30), topRight: Radius.circular(30)),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, -15),
            blurRadius: 20,
            color: const Color(0xffdadada).withOpacity(0.15),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  color: const Color(0xfff5f6f9),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: SvgPicture.asset('assets/icons/coupon.svg'),
                ),
              ),
              const SizedBox(width: 10),
              const Text('Mã khuyến mãi'),
              const Spacer(),
              const Text(
                'Nhập hoặc chọn mã',
                style: TextStyle(color: textNoteColor),
              ),
              const SizedBox(width: 10),
              const Icon(Icons.arrow_forward_ios,
                  size: 12, color: textNoteColor),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text.rich(
                TextSpan(
                  text: 'Tổng cộng:\n',
                  children: [
                    TextSpan(
                      text: '$total đ',
                      style: const TextStyle(
                          fontSize: 20,
                          color: kPrimaryColor,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              // SizedBox(
              //   width: 190,
              //   height: 40,
              //   child: ElevatedButton(
              //     style: ElevatedButton.styleFrom(
              //         shape: RoundedRectangleBorder(
              //             borderRadius: BorderRadius.circular(10.0)),
              //         backgroundColor: kPrimaryColor),
              //     onPressed: () {
              //       Navigator.push(
              //         context,
              //         PageTransition(
              //             child: CheckoutScreen(
              //               cart: demoCarts[0],
              //             ),
              //             type: PageTransitionType.leftToRightWithFade),
              //       );
              //     },
              //     child: const Text(
              //       'Đặt dịch vụ',
              //       style: TextStyle(fontSize: 17),
              //     ),
              //   ),
              // )
            ],
          )
        ],
      ),
    );
  }
}
