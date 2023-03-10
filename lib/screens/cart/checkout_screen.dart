// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../../components/constants/color_constants.dart';
import '../../models/cart.dart';
import 'components/checkout/order_card.dart';
import 'components/checkout/service_ordered.dart';
import 'information/shipping/shipping_address.dart';
import 'information/shipping/shipping_method.dart';

class CheckoutScreen extends StatefulWidget {
  final Cart cart;
  const CheckoutScreen({
    Key? key,
    required this.cart,
  }) : super(key: key);

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  @override
  Widget build(BuildContext context) {
    double total = 0.0;
    for (int i = 0; i < demoCarts.length; i++) {
      total += demoCarts[i].numOfItems.value * demoCarts[i].service.price;
    }
    int paymentIndex = 0;
    return Scaffold(
      backgroundColor: kBackgroundColor,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0,
        backgroundColor:
            kPrimaryColor, //Theme.of(context).scaffoldBackgroundColor
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        title: const Align(
          alignment: Alignment.center,
          child: Text('Thanh toán',
              style: TextStyle(color: Colors.white, fontSize: 24)),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 22),
            child: Icon(Icons.abc, color: kPrimaryColor),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const ShippingAddress(),
            separateLine(),
            const ServiceOrdered(),
            separateLine(),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: const [
                      Text(
                        'Phương thức thanh toán',
                        style: TextStyle(
                            color: textColor,
                            fontSize: 18,
                            fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.only(left: 16, right: 16),
                    height: 50,
                    width: double.infinity,
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 1,
                        color: Colors.grey.shade400,
                      ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              width: 35,
                              child: Image.asset(
                                  'assets/images/shipping/cash-on-delivery.png'),
                            ),
                            const SizedBox(width: 8),
                            const Text(
                              'Thanh toán bằng tiền mặt',
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                        Radio(
                          activeColor: kPrimaryColor,
                          value: 1,
                          groupValue: paymentIndex,
                          onChanged: (Object? newVal) {
                            paymentIndex = setPayment(paymentIndex, newVal);
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.only(left: 16, right: 16),
                    height: 50,
                    width: double.infinity,
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 1,
                        color: Colors.grey.shade400,
                      ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              width: 35,
                              child: Image.asset(
                                  'assets/images/shipping/logo-momo-png-1.png'),
                            ),
                            const SizedBox(width: 8),
                            const Text(
                              'Thanh toán bằng Momo',
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                        Radio(
                          value: 2,
                          groupValue: paymentIndex,
                          onChanged: (Object? newVal) {
                            paymentIndex = setPayment(paymentIndex, newVal);
                          },
                        ),
                        // Container(
                        //   width: 15,
                        //   height: 15,
                        //   decoration: ShapeDecoration(
                        //       shape: CircleBorder(
                        //           side:
                        //               BorderSide(color: Colors.grey.shade400))),
                        // )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            separateLine(),
            const ShippingMethod(),
            separateLine(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Chi tiết thanh toán',
                    style: TextStyle(
                        color: textColor,
                        fontSize: 18,
                        fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Tạm tính:',
                              style: TextStyle(fontSize: 16),
                            ),
                            Text(
                              '$total đ',
                              style: const TextStyle(
                                  fontSize: 16,
                                  color: textColor,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text(
                              'Phí ship:',
                              style: TextStyle(fontSize: 16),
                            ),
                            Text(
                              '0 đ',
                              style: TextStyle(
                                  fontSize: 16,
                                  color: textColor,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                        Divider(
                          height: 40,
                          color: Colors.grey.shade300,
                          thickness: 2,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Tổng cộng:',
                              style: TextStyle(fontSize: 17),
                            ),
                            Text(
                              '$total đ',
                              style: const TextStyle(
                                  fontSize: 17,
                                  color: kPrimaryColor,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: const OrderCard(),
    );
  }

  Column separateLine() {
    return Column(
      children: [
        const SizedBox(height: 15),
        Container(
          height: 10,
          width: double.infinity,
          color: Colors.grey.shade200,
        ),
        const SizedBox(height: 15),
      ],
    );
  }

  int setPayment(int paymentIndex, Object? newVal) {
    setState(() {
      paymentIndex = int.parse(newVal.toString());
    });
    return paymentIndex;
  }
}
