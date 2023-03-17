import 'package:flutter/material.dart';

import '../../../../components/constants/color_constants.dart';
import '../../../../models/cart.dart';
import 'detail_item_card.dart';

class DetailService extends StatelessWidget {
  const DetailService({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
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
              itemCount: demoCarts.length,
              itemBuilder: (context, index) {
                return DetailItemCard(
                  cart: demoCarts[index],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
