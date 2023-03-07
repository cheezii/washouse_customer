import 'package:flutter/material.dart';

import '../../../../components/constants/color_constants.dart';
import 'choose_shipping_method.dart';

class ShippingMethod extends StatelessWidget {
  const ShippingMethod({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: ((context) => const ChooseShippingMethod())));
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Phương thức vận chuyển',
                  style: TextStyle(
                      color: textColor,
                      fontSize: 18,
                      fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 35,
                        child:
                            Image.asset('assets/images/shipping/ship-di.png'),
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        'Không sử dụng dịch vụ vận chuyển',
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const Icon(
              Icons.arrow_forward_ios_rounded,
              color: textColor,
            )
          ],
        ),
      ),
    );
  }
}
