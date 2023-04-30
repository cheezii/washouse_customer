import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:washouse_customer/resource/models/response_models/order_detail_information.dart';
import 'package:washouse_customer/utils/price_util.dart';
import 'package:flutter/src/widgets/basic.dart' as basic;

import '../../../../components/constants/color_constants.dart';
import '../../../../resource/provider/cart_provider.dart';
import '../../../../resource/models/cart_item.dart';

class DetailItemCard extends StatelessWidget {
  final OrderedDetails cart;
  final bool isProcessing;
  const DetailItemCard({
    super.key,
    required this.cart,
    required this.isProcessing,
  });

  @override
  Widget build(BuildContext context) {
    //List<CartItem> cartItems = Provider.of<CartProvider>(context).cartItems;
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              cart.image!, // replace with your own image URL
              width: 80, // set your desired width here
              height: 80, // set your desired height here
              fit: BoxFit
                  .cover, // set the image fit to cover the entire container
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return basic.Center(
                  child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded.toDouble() /
                              loadingProgress.expectedTotalBytes!.toDouble()
                          : null),
                );
              }, // replace with your own loading widget
              // ignore: prefer_const_constructors
              errorBuilder: (context, error, stackTrace) => SizedBox(
                width: 80,
                height: 80,
                // ignore: prefer_const_constructors
                child: Icon(Icons.error),
              ),
            ),
          ),
          const SizedBox(width: 20),
          isProcessing
              ? Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 200,
                        child: Text(
                          //cart.service.name!,
                          cart.serviceName!,
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
                            cart.unit!.compareTo('Kg') == 0
                                ? 'KL: x${cart.measurement} kg'
                                : 'SL: x${cart.measurement!.round()} ${cart.unit!.toLowerCase()}',
                            style:
                                const TextStyle(color: textColor, fontSize: 16),
                          ),
                          const Spacer(),
                          const Text(
                            'Trạng thái',
                            style: TextStyle(
                                color: kPrimaryColor,
                                fontSize: 16,
                                fontWeight: FontWeight.w500),
                          )
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        //'${PriceUtils().convertFormatPrice(cart.service.price!.round() * cart.measurement)} đ',
                        '${PriceUtils().convertFormatPrice(cart.price!.round())} đ',
                        style: const TextStyle(
                          color: kPrimaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                )
              : Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 200,
                        child: Text(
                          //cart.service.name!,
                          cart.serviceName!,
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
                            cart.unit!.compareTo('Kg') == 0
                                ? 'KL: x${cart.measurement} kg'
                                : 'SL: x${cart.measurement!.round()} ${cart.unit!.toLowerCase()}',
                            style:
                                const TextStyle(color: textColor, fontSize: 16),
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
      ),
    );
  }
}
