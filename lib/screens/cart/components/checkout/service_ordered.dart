import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../components/constants/color_constants.dart';
import '../../../../resource/controller/cart_provider.dart';
import '../../../../resource/models/cart_item.dart';
import '../../../../utils/price_util.dart';
import 'temp_delete/checkout_item_card.dart';

class ServiceOrdered extends StatelessWidget {
  const ServiceOrdered({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    List<CartItem> cartItems = Provider.of<CartProvider>(context).cartItems;
    return Consumer<CartProvider>(
      builder: (context, value, child) {
        {
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
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
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
                  //itemCount: demoCarts.length,
                  itemCount: cartItems.length,
                  itemBuilder: (context, index) {
                    bool checkUnitType;
                    //if (demoCarts[index].service.unit?.compareTo('Kg') == 0) {
                    if (cartItems[index].unit?.compareTo('Kg') == 0) {
                      checkUnitType = true;
                    } else {
                      checkUnitType = false;
                    }
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
                              child:
                                  //Image.asset(demoCarts[index].service.image!),
                                  Image.network(cartItems[index].thumbnail!),
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
                                  //demoCarts[index].service.name!,
                                  cartItems[index].name,
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
                                  checkUnitType
                                      ? Text(
                                          //'KL: x${demoCarts[index].measurement} kg',
                                          'KL: x${cartItems[index].measurement} kg',
                                          style: const TextStyle(
                                              color: textColor, fontSize: 16),
                                        )
                                      : Text(
                                          //'SL: x${demoCarts[index].measurement}',
                                          'SL: x${cartItems[index].measurement.round()}',
                                          style: const TextStyle(
                                              color: textColor, fontSize: 16),
                                        ),
                                  const Spacer(),
                                  Text(
                                    '${PriceUtils().convertFormatPrice((cartItems[index].price!.round() * cartItems[index].measurement).toInt())} đ',
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
                  },
                ),
              ),
            ],
          );
        }
      },
    );
  }
}
