import 'package:flutter/material.dart';
import 'package:washouse_customer/resource/models/cart_item.dart';

import '../../../../components/constants/color_constants.dart';
import '../../cart_screen.dart';

class ChooseShippingMethod extends StatefulWidget {
  const ChooseShippingMethod({super.key});

  @override
  State<ChooseShippingMethod> createState() => _ChooseShippingMethodState();
}

class _ChooseShippingMethodState extends State<ChooseShippingMethod> {
  @override
  Widget build(BuildContext context) {
    //1 = không chọn, 2 = một chiều đi, 3 = một chiều về, 4 = 2 chiều
    int typeIndex = 1;
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(height: 16),
          RadioListTile(
            title: Row(
              children: [
                SizedBox(
                  width: 35,
                  child: Image.asset('assets/images/shipping/ship-di.png'),
                ),
                const SizedBox(width: 8),
                const Text(
                  'Không sử dụng dịch vụ vận chuyển',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
            value: 1,
            groupValue: typeIndex,
            onChanged: ((value) {
              setState(() {
                typeIndex = int.parse(value.toString());
              });
            }),
          ),
          const SizedBox(height: 8),
          RadioListTile(
            title: Row(
              children: [
                SizedBox(
                  width: 35,
                  child: Image.asset('assets/images/shipping/dua-den.png'),
                ),
                const SizedBox(width: 8),
                const Text(
                  'Vận chuyển một chiều đi',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
            value: 2,
            groupValue: typeIndex,
            onChanged: ((value) {
              setState(() {
                typeIndex = int.parse(value.toString());
              });
            }),
          ),
          const SizedBox(height: 8),
          RadioListTile(
            title: Row(
              children: [
                SizedBox(
                  width: 35,
                  child: Image.asset('assets/images/shipping/giao-den.png'),
                ),
                const SizedBox(width: 8),
                const Text(
                  'Vận chuyển một chiều về',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
            value: 3,
            groupValue: typeIndex,
            onChanged: ((value) {
              setState(() {
                typeIndex = int.parse(value.toString());
              });
            }),
          ),
          const SizedBox(height: 8),
          RadioListTile(
            title: Row(
              children: [
                SizedBox(
                  width: 35,
                  child: Image.asset('assets/images/shipping/shipper.png'),
                ),
                const SizedBox(width: 8),
                const Text(
                  'Vận chuyển hai chiều',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
            value: 4,
            groupValue: typeIndex,
            onChanged: ((value) {
              setState(() {
                typeIndex = int.parse(value.toString());
              });
            }),
          ),
        ],
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
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const CartScreen()));
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
