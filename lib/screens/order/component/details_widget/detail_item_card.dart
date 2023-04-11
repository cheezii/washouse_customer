import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:washouse_customer/utils/price_util.dart';

import '../../../../components/constants/color_constants.dart';
import '../../../../resource/controller/cart_provider.dart';
import '../../../../resource/models/cart_item.dart';

class DetailItemCard extends StatelessWidget {
  final CartItem cart;
  const DetailItemCard({
    super.key,
    required this.cart,
  });

  @override
  Widget build(BuildContext context) {
    //List<CartItem> cartItems = Provider.of<CartProvider>(context).cartItems;
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
              //child: Image.asset(cart.service.image!),
              child: Image.network(cart.thumbnail!),
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
                  //cart.service.name!,
                  cart.name,
                  style: const TextStyle(fontSize: 17, color: Colors.black, fontWeight: FontWeight.bold),
                  maxLines: 2,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Text(
                    cart.unit!.compareTo('Kg') == 0 ? 'KL: x${cart.measurement}' : 'SL: x${cart.measurement.toInt()}',
                    style: const TextStyle(color: textColor, fontSize: 16),
                  ),
                  const Spacer(),
                  Text(
                    //'${PriceUtils().convertFormatPrice(cart.service.price!.round() * cart.measurement)} đ',
                    '${PriceUtils().convertFormatPrice(cart.price!.round())} đ',
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
