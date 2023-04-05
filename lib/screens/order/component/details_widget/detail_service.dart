import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../components/constants/color_constants.dart';
import '../../../../resource/controller/cart_provider.dart';
import '../../../../resource/models/cart_item.dart';
import 'detail_item_card.dart';

class DetailService extends StatelessWidget {
  const DetailService({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    List<CartItem> cartItems = Provider.of<CartProvider>(context).cartItems;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Row(
            children: const [
              Icon(
                Icons.local_laundry_service_rounded,
                color: kPrimaryColor,
                size: 24,
              ),
              SizedBox(width: 6),
              Text(
                'The Clean House',
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
              )
            ],
          ),
          const SizedBox(height: 6),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              //itemCount: demoCarts.length,
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                return DetailItemCard(
                  //cart: demoCarts[index],
                  cart: cartItems[index],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
