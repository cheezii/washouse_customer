import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:washouse_customer/resource/controller/base_controller.dart';
import 'package:washouse_customer/resource/models/cart_item.dart';
import 'package:washouse_customer/screens/cart/checkout_screen.dart';
import 'package:washouse_customer/screens/cart/information/shipping/shipping_information.dart';

import '../../../../components/constants/color_constants.dart';
import '../../../../resource/controller/cart_provider.dart';
import '../../cart_screen.dart';

class ChooseShippingMethod extends StatefulWidget {
  const ChooseShippingMethod({super.key});

  @override
  State<ChooseShippingMethod> createState() => _ChooseShippingMethodState();
}

class _ChooseShippingMethodState extends State<ChooseShippingMethod> {
  int? shippingMethod;
  BaseController baseController = BaseController();
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<CartProvider>(context);
    List<CartItem> cartItems = Provider.of<CartProvider>(context).cartItems;
    //0 = không chọn, 1 = một chiều đi, 2 = một chiều về, 3 = 2 chiều
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor:
            kPrimaryColor, //Theme.of(context).scaffoldBackgroundColor
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.close_rounded,
            color: Colors.white,
            size: 26,
          ),
        ),
        title: const Align(
          alignment: Alignment.center,
          child: Text('Phương thức vận chuyển',
              style: TextStyle(color: Colors.white, fontSize: 22)),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 22),
            child: Icon(
              Icons.abc,
              color: kPrimaryColor,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 16, right: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: 35,
                      child: Image.asset('assets/images/shipping/ship-di.png'),
                    ),
                    const SizedBox(width: 10),
                    const Text(
                      'Không sử dụng dịch vụ vận chuyển',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
                Radio(
                  value: 0,
                  groupValue: shippingMethod,
                  onChanged: (newVal) {
                    setState(() {
                      shippingMethod = newVal;
                      baseController.saveInttoSharedPreference(
                          "deliveryType", newVal);
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: 35,
                      child: Image.asset('assets/images/shipping/dua-den.png'),
                    ),
                    const SizedBox(width: 10),
                    const Text(
                      'Vận chuyển 1 chiều đi',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
                Radio(
                  value: 1,
                  groupValue: shippingMethod,
                  onChanged: (newVal) {
                    setState(() {
                      shippingMethod = newVal;
                      baseController.saveInttoSharedPreference(
                          "deliveryType", newVal);
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: 35,
                      child: Image.asset('assets/images/shipping/giao-den.png'),
                    ),
                    const SizedBox(width: 16),
                    const Text(
                      'Vận chuyển 1 chiều về',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
                Radio(
                  value: 2,
                  groupValue: shippingMethod,
                  onChanged: (newVal) {
                    setState(() {
                      shippingMethod = newVal;
                      baseController.saveInttoSharedPreference(
                          "deliveryType", newVal);
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: 35,
                      child: Image.asset('assets/images/shipping/shipper.png'),
                    ),
                    const SizedBox(width: 16),
                    const Text(
                      'Vận chuyển 2 chiều',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
                Radio(
                  value: 3,
                  groupValue: shippingMethod,
                  onChanged: (newVal) {
                    setState(() {
                      shippingMethod = newVal;
                      baseController.saveInttoSharedPreference(
                          "deliveryType", newVal);
                    });
                  },
                ),
              ],
            )
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
        height: 70,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30)),
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, -15),
              blurRadius: 20,
              color: const Color(0xffdadada).withOpacity(0.15),
            ),
          ],
        ),
        child: SizedBox(
          width: 190,
          height: 40,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                backgroundColor: kPrimaryColor),
            onPressed: () {
              if (shippingMethod == 0) {
                baseController.saveDoubletoSharedPreference("deliveryPrice", 0);
                provider.updateDeliveryPrice();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CheckoutScreen(cart: cartItems[0]),
                  ),
                );
              } else {
                if (shippingMethod == 1) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const FillShippingInformation(
                        isSend: true,
                        isReceive: false,
                      ),
                    ),
                  );
                } else if (shippingMethod == 2) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const FillShippingInformation(
                        isSend: false,
                        isReceive: true,
                      ),
                    ),
                  );
                } else if (shippingMethod == 3) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const FillShippingInformation(
                        isSend: true,
                        isReceive: true,
                      ),
                    ),
                  );
                }
              }
            },
            child: const Text(
              'Xác nhận',
              style: TextStyle(fontSize: 17),
            ),
          ),
        ),
      ),
    );
  }
}
