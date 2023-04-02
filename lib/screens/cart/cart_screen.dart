import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../components/constants/color_constants.dart';
import '../../resource/models/cart_item.dart';
import '../../utils/price_util.dart';
import 'components/cart/add_voucher.dart';
import 'components/cart/cart_body_screen.dart';
import 'components/cart/temp_delete/cart_item_card.dart';
import 'components/cart/checkout_card.dart';
import 'information/shipping/fill_shipping_address.dart';

class CartScreen extends StatefulWidget {
  final centerName;
  const CartScreen({super.key, this.centerName});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  late String _centerName;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _centerName = widget.centerName;
  }

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
      body: CartBodyScreen(centerName: _centerName),
      bottomNavigationBar: const CheckOutCard(),
    );
  }
}
