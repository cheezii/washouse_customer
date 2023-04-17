import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../components/constants/color_constants.dart';
import '../../../../resource/provider/cart_provider.dart';
import '../../../../resource/models/cart_item.dart';
import '../../../../resource/models/response_models/order_detail_information.dart';
import 'detail_item_card.dart';

class DetailService extends StatefulWidget {
  final Order_Infomation order_information;
  const DetailService({super.key, required this.order_information});

  @override
  State<DetailService> createState() => _DetailServiceState();
}

class _DetailServiceState extends State<DetailService> {
  @override
  Widget build(BuildContext context) {
    Order_Infomation orderInfo = widget.order_information;
    List<CartItem> cartItems = Provider.of<CartProvider>(context).cartItems;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Row(
            children: [
              const Icon(
                Icons.local_laundry_service_rounded,
                color: kPrimaryColor,
                size: 24,
              ),
              const SizedBox(width: 6),
              Text(
                orderInfo.center!.centerName!,
                style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
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
              itemCount: orderInfo.orderedDetails!.length,
              itemBuilder: (context, index) {
                return DetailItemCard(
                  //cart: demoCarts[index],
                  cart: orderInfo.orderedDetails![index],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
