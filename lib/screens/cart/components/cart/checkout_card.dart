import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:washouse_customer/screens/cart/information/shipping/fill_shipping_address.dart';

import '../../../../components/constants/color_constants.dart';
import '../../../../resource/controller/cart_provider.dart';
import '../../../../resource/models/cart_item.dart';
import '../../../../utils/price_util.dart';
import '../../checkout_screen.dart';
import 'add_voucher.dart';

class CheckOutCard extends StatefulWidget {
  const CheckOutCard({
    super.key,
  });

  @override
  State<CheckOutCard> createState() => _CheckOutCardState();
}

class _CheckOutCardState extends State<CheckOutCard> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<CartProvider>(context);
    bool haveCart = true;
    if (provider.cartItems.length == 0) {
      haveCart = false;
    }
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
      height: 150,
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
      child: Column(
        children: [
          GestureDetector(
            onTap: haveCart
                ? () {
                    Navigator.push(
                        context,
                        PageTransition(
                            child: const AddVoucherScreen(),
                            type: PageTransitionType.rightToLeftWithFade));
                  }
                : null,
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
                Consumer<CartProvider>(builder: (context, value, child) {
                  return Text(
                    (value.promoCode! != '')
                        ? value.promoCode!
                        : 'Chọn mã khuyến mãi',
                    style: TextStyle(color: textNoteColor),
                  );
                }),
                const SizedBox(width: 10),
                const Icon(Icons.arrow_forward_ios,
                    size: 12, color: textNoteColor),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Consumer<CartProvider>(
            builder: (context, value, child) {
              bool checkPrice;
              if (value.getTotalPrice() > 0) {
                //print("value.getTotalPrice()${value.getTotalPrice()}");
                checkPrice = true;
              } else {
                checkPrice = false;
              }
              bool checkItem;
              //print("cartLength${value.cartItems.length}");
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
                                text: (checkPrice &&
                                        value.cartItems.length != 0)
                                    //? '${PriceUtils().convertFormatPrice(value.getTotalPrice().round())} đ'
                                    ? '${PriceUtils().convertFormatPrice(value.cartItems.fold(0.0, (sum, item) => sum + item.price!).round())} đ'
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
                          text: (checkPrice && value.cartItems.length != 0)
                              //? '${PriceUtils().convertFormatPrice(value.getTotalPrice().round())} đ'
                              ? '${PriceUtils().convertFormatPrice((value.cartItems.fold(0.0, (sum, item) => sum + item.price!) * (1 - value.discount)).round())} đ'
                              : '0 đ',
                          style: const TextStyle(
                              fontSize: 20,
                              color: kPrimaryColor,
                              fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    width: 190,
                    height: 40,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                          backgroundColor: kPrimaryColor),
                      onPressed: haveCart
                          ? () {
                              Navigator.push(
                                context,
                                PageTransition(
                                    child: const FillAddressScreen(),
                                    type:
                                        PageTransitionType.rightToLeftWithFade),
                              );
                            }
                          : null,
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
