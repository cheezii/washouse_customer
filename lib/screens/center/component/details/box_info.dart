// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:washouse_customer/components/constants/color_constants.dart';

class BoxInfo extends StatelessWidget {
  final String icon;
  final String title;
  final String pressText;
  final GestureTapCallback press;
  const BoxInfo({
    Key? key,
    required this.icon,
    required this.title,
    required this.pressText,
    required this.press,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      height: 50,
      width: size.width,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 1.0, color: Colors.grey.shade300),
        ),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 35,
            child: Image.asset(icon),
          ),
          const SizedBox(width: 15),
          Text(
            title,
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.grey.shade800),
          ),
          const Spacer(),
          TextButton(
            onPressed: press,
            child: Text(
              pressText,
              style: TextStyle(fontSize: 15),
            ),
          ),
        ],
      ),
    );
  }
}
