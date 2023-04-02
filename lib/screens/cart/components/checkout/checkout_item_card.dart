import 'package:flutter/material.dart';

import '../../../../components/constants/color_constants.dart';
import '../../../../resource/models/cart_item.dart';
import '../../../../utils/price_util.dart';

class CheckoutItemCard extends StatelessWidget {
  final CartItem cart;
  const CheckoutItemCard({
    super.key,
    required this.cart,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 80,
          child: AspectRatio(
            aspectRatio: 0.88,
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: const Color(0xfff5f6f9),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Image.asset(cart.service.image![0]),
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
                  cart.service.name!,
                  style: const TextStyle(
                      fontSize: 17,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                  maxLines: 2,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Text(
                    'SL: x${cart.measurement}',
                    style: const TextStyle(color: textColor, fontSize: 16),
                  ),
                  const Spacer(),
                  Text(
<<<<<<< Updated upstream
                    '${cart.service.price! * cart.numOfItems.value} đ',
=======
                    '${PriceUtils().convertFormatPrice(cart.service.price!.round() * cart.measurement)} đ',
>>>>>>> Stashed changes
                    style: const TextStyle(
                      color: kPrimaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
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
