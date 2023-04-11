import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:washouse_customer/resource/controller/order_controller.dart';
import 'package:washouse_customer/screens/home/home_screen.dart';
import 'package:washouse_customer/utils/price_util.dart';

import '../../../../components/constants/color_constants.dart';
import '../../../../resource/controller/cart_provider.dart';
import '../../../../resource/models/cart_item.dart';
import '../../../home/base_screen.dart';
import '../../checkout_screen.dart';
import '../cart/add_voucher.dart';

class OrderCard extends StatelessWidget {
  const OrderCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    OrderController orderController = OrderController(context);
    List<CartItem> cartItems = Provider.of<CartProvider>(context).cartItems;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
      height: 174,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, -15),
            blurRadius: 20,
            color: const Color(0xffdadada).withOpacity(0.15),
          ),
        ],
      ),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(context, PageTransition(child: const AddVoucherScreen(), type: PageTransitionType.rightToLeftWithFade));
            },
            child: Row(
              children: [
                Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    color: const Color(0xfff5f6f9),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: SvgPicture.asset('assets/icons/coupon.svg'),
                  ),
                ),
                const SizedBox(width: 10),
                const Text('Mã khuyến mãi'),
                const Spacer(),
                // const Text(
                //   'Nhập hoặc chọn mã',
                //   style: TextStyle(color: textNoteColor),
                // ),
                Consumer<CartProvider>(builder: (context, value, child) {
                  return Text(
                    (value.promoCode! != '') ? value.promoCode! : 'Chọn mã khuyến mãi',
                    style: TextStyle(color: textNoteColor),
                  );
                }),
                const SizedBox(width: 10),
                const Icon(Icons.arrow_forward_ios, size: 12, color: textNoteColor),
              ],
            ),
          ),
          const SizedBox(height: 20),
          // Consumer<CartProvider>(
          //   builder: (context, value, child) {
          //     {
          //       bool checkPrice;
          //       if (value.getTotalPrice() > 0) {
          //         checkPrice = true;
          //       } else {
          //         checkPrice = false;
          //       }
          //       return Row(
          //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //         children: [
          //           Text.rich(
          //             TextSpan(
          //               text: 'Tổng cộng dự kiến:\n',
          //               children: [
          //                 TextSpan(
          //                   text: checkPrice
          //                       //? '${PriceUtils().convertFormatPrice(value.getTotalPrice().round())} đ'
          //                       ? '${PriceUtils().convertFormatPrice(value.cartItems.fold(0.0, (sum, item) => sum + item.price!).round())} đ'
          //                       : '0 đ',
          //                   style: const TextStyle(
          //                       fontSize: 20,
          //                       color: kPrimaryColor,
          //                       fontWeight: FontWeight.bold),
          //                 ),
          //               ],
          //             ),
          //           ),
          //           SizedBox(
          //             width: 190,
          //             height: 40,
          //             child: ElevatedButton(
          //               style: ElevatedButton.styleFrom(
          //                   shape: RoundedRectangleBorder(
          //                       borderRadius: BorderRadius.circular(10.0)),
          //                   backgroundColor: kPrimaryColor),
          //               onPressed: () {
          //                 Navigator.push(
          //                   context,
          //                   PageTransition(
          //                       child: CheckoutScreen(
          //                         //cart: demoCarts[0],
          //                         cart: cartItems[0],
          //                       ),
          //                       type: PageTransitionType.leftToRightWithFade),
          //                 );
          //               },
          //               child: const Text(
          //                 'Đặt dịch vụ',
          //                 style: TextStyle(fontSize: 17),
          //               ),
          //             ),
          //           )
          //         ],
          //       );
          //     }
          //   },
          // )
          Consumer<CartProvider>(
            builder: (context, value, child) {
              bool checkPrice;
              if (value.getTotalPrice() > 0) {
                checkPrice = true;
              } else {
                checkPrice = false;
              }
              bool checkItem;
              //if (value.getCounter() > 0) {
              if (value.cartItems.length > 0) {
                checkItem = true;
              } else {
                checkItem = false;
              }
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Tổng cộng dự kiến'),
                      (value.discount != 0)
                          ? Text.rich(
                              TextSpan(
                                text: checkPrice
                                    //? '${PriceUtils().convertFormatPrice(value.getTotalPrice().round())} đ'
                                    ? '${PriceUtils().convertFormatPrice((value.cartItems.fold(0.0, (sum, item) => sum + item.price!) + value.deliveryPrice).round())} đ'
                                    : '0 đ',
                                style: const TextStyle(
                                    fontSize: 15,
                                    color: kPrimaryColor,
                                    decoration: TextDecoration.lineThrough,
                                    decorationColor: Colors.black,
                                    decorationThickness: 2.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            )
                          : SizedBox(),
                      Text.rich(
                        TextSpan(
                          text: checkPrice
                              //? '${PriceUtils().convertFormatPrice(value.getTotalPrice().round())} đ'
                              ? '${PriceUtils().convertFormatPrice((value.cartItems.fold(0.0, (sum, item) => sum + item.price!) * (1 - value.discount) + value.deliveryPrice).round())} đ'
                              : '0 đ',
                          style: const TextStyle(fontSize: 20, color: kPrimaryColor, fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    width: 190,
                    height: 40,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)), backgroundColor: kPrimaryColor),
                      onPressed: () async {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            });
                        String? message = await orderController.createOrder();
                        print(message);
                        Navigator.of(context).pop();
                        Navigator.push(context, PageTransition(child: const BaseScreen(), type: PageTransitionType.rightToLeftWithFade));
                      },
                      child: Text(
                        //'Thanh toán (${checkItem ? value.getCounter() : 0})',
                        'Đặt dịch vụ (${value.cartItems.length})',
                        style: const TextStyle(fontSize: 17),
                      ),
                    ),
                  )
                ],
              );
            },
          )
        ],
      ),
    );
  }
}
