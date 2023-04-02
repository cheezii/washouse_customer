import 'package:flutter/material.dart';
import '../../components/constants/color_constants.dart';
import 'components/cart/cart_body_screen.dart';
import 'components/cart/checkout_card.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

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
            Icons.close_rounded,
            color: Colors.white,
            size: 26,
          ),
        ),
        title: const Align(
          alignment: Alignment.center,
          child: Text('Giỏ hàng',
              style: TextStyle(color: Colors.white, fontSize: 24)),
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
      body: const CartBodyScreen(),
      bottomNavigationBar: const CheckOutCard(),
    );
  }
}
