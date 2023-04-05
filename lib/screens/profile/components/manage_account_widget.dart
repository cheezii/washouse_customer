// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../../../components/constants/color_constants.dart';

class ManageAccountWidget extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final Color txtColor;
  final GestureTapCallback press;
  const ManageAccountWidget({
    Key? key,
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.txtColor,
    required this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: press,
      style: ElevatedButton.styleFrom(
          padding: const EdgeInsetsDirectional.symmetric(
              horizontal: 19, vertical: 16),
          foregroundColor: kPrimaryColor.withOpacity(.7),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: BorderSide(color: kPrimaryColor.withOpacity(.5), width: 1),
          ),
          backgroundColor: Colors.white),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: iconColor.withOpacity(.6),
            size: 26.0,
          ),
          const SizedBox(width: 16),
          Text(
            title,
            style: TextStyle(
              color: txtColor,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          )
        ],
      ),
    );
  }
}
