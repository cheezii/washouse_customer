// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class ProfileWidget extends StatelessWidget {
  final IconData icon;
  final String title;
  final Color txtColor;
  final Color iconColor;
  final GestureTapCallback press;
  const ProfileWidget({
    Key? key,
    required this.icon,
    required this.title,
    required this.txtColor,
    required this.iconColor,
    required this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 18.0),
      child: GestureDetector(
        onTap: press,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
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
            Icon(
              Icons.arrow_forward_ios,
              color: iconColor.withOpacity(.5),
              size: 18.0,
            ),
          ],
        ),
      ),
    );
  }
}
