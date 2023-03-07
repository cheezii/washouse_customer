import 'package:flutter/material.dart';

import '../../../../components/constants/color_constants.dart';
import '../../../../models/cart.dart';
import 'checkout_item_card.dart';

class ServiceOrdered extends StatelessWidget {
  const ServiceOrdered({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: const [
              Icon(
                Icons.local_laundry_service_rounded,
                color: kPrimaryColor,
                size: 26,
              ),
              SizedBox(width: 6),
              Text(
                'The Clean House',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              )
            ],
          ),
        ),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 26),
          child: ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: demoCarts.length,
            itemBuilder: (context, index) {
              return CheckoutItemCard(
                cart: demoCarts[index],
              );
            },
          ),
        ),
      ],
    );
  }
}
