import 'package:flutter/material.dart';
import 'package:washouse_customer/components/constants/size.dart';

import '../../../components/constants/color_constants.dart';

class TitleWithMoreBtn extends StatelessWidget {
  const TitleWithMoreBtn({super.key, required this.title, required this.press, s});
  final String title;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
        ),
        IconButton(
          onPressed: press,
          icon: const Icon(
            Icons.arrow_forward_ios_rounded,
            size: 20,
          ),
        ),
      ],
    );
  }
}
