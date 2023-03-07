import 'package:flutter/material.dart';

import '../../../../components/constants/color_constants.dart';
import '../../../../models/shipping.dart';
import 'fill_shipping_address.dart';

class ShippingAddress extends StatelessWidget {
  const ShippingAddress({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, right: 16, left: 16),
      child: Column(
        children: [
          Row(
            children: [
              const Icon(
                Icons.location_on_rounded,
                color: kPrimaryColor,
                size: 23,
              ),
              const SizedBox(width: 6),
              Text(
                shipping.fullName + '  |  ' + shipping.shippedPhone,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  shipping.shippedAddress,
                  style: TextStyle(color: Colors.grey.shade700, fontSize: 16),
                  overflow: TextOverflow.clip,
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const FillAddressScreen()));
                },
                child: Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: Colors.grey.shade700,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
