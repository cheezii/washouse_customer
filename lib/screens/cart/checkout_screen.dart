// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:washouse_customer/utils/price_util.dart';

import '../../components/constants/color_constants.dart';
import '../../resource/controller/cart_provider.dart';
import '../../resource/models/cart_item.dart';
import 'components/checkout/order_card.dart';
import 'components/checkout/service_ordered.dart';
import 'information/shipping/shipping_address.dart';
import 'information/shipping/shipping_method.dart';

class CheckoutScreen extends StatefulWidget {
  final CartItem cart;
  const CheckoutScreen({
    Key? key,
    required this.cart,
  }) : super(key: key);

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  int? payment;
  @override
  Widget build(BuildContext context) {
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
            // const ShippingAddress(),
            // separateLine(),
            const SizedBox(height: 16),
            const ServiceOrdered(), //map data của cart vào cái này
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
                          value: 0,
                          groupValue: payment,
                          onChanged: (newVal) {
                            setState(() {
                              payment = newVal;
                            });
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
                                  'assets/images/shipping/vnpay-icon.png'),
                            ),
                            const SizedBox(width: 8),
                            const Text(
                              'Thanh toán bằng VNPay',
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                        Radio(
                          value: 1,
                          groupValue: payment,
                          onChanged: (newVal) {
                            setState(() {
                              payment = newVal;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            separateLine(),
            const ShippingMethod(),
            separateLine(),
            Consumer<CartProvider>(
              builder: (context, value, child) {
                {
                  return Padding(
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'Tạm tính:',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  Text(
                                    //'${PriceUtils().convertFormatPrice(value.getTotalPrice().round())} đ',
                                    '${PriceUtils().convertFormatPrice(value.cartItems.fold(0.0, (sum, item) => sum + item.price!).round())} đ',
                                    style: const TextStyle(
                                        fontSize: 16,
                                        color: textColor,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                              const SizedBox(height: 15),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: const [
                                  Text(
                                    'Mã giảm giá:',
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
                              const SizedBox(height: 15),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'Tổng cộng:',
                                    style: TextStyle(fontSize: 17),
                                  ),
                                  Text(
                                    //'${PriceUtils().convertFormatPrice(value.getTotalPrice().round())} đ',
                                    '${PriceUtils().convertFormatPrice(value.cartItems.fold(0.0, (sum, item) => sum + item.price!).round())} đ',
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
                  );
                }
              },
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
}
