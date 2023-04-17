import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../components/constants/color_constants.dart';
import '../../../../resource/provider/cart_provider.dart';
import 'choose_shipping_method.dart';

class ShippingMethod extends StatelessWidget {
  const ShippingMethod({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: ((context) => const ChooseShippingMethod())));
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
                  style: TextStyle(color: textColor, fontSize: 18, fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 35,
                        child: Image.asset('assets/images/shipping/ship-di.png'),
                      ),
                      const SizedBox(width: 8),
                      Consumer<CartProvider>(
                        builder: (context, value, child) {
                          String textReturn;
                          if (value.deliveryType == 0) {
                            textReturn = 'Không sử dụng dịch vụ vận chuyển';
                          } else if (value.deliveryType == 1) {
                            textReturn = 'Vận chuyển từ bạn tới cửa hàng';
                          } else if (value.deliveryType == 2) {
                            textReturn = 'Vận chuyển từ cửa hàng đến bạn';
                          } else if (value.deliveryType == 3) {
                            textReturn = 'Vận chuyển hai chiều';
                          } else {
                            textReturn = 'Không sử dụng dịch vụ vận chuyển';
                          }
                          return Text(
                            textReturn,
                            style: const TextStyle(fontSize: 16),
                          );
                        },
                      )
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
