import 'package:flutter/material.dart';

class ProfileWidget extends StatelessWidget {
  final IconData icon;
  final String title;
  final Color txtColor;
  final Color iconColor;
  const ProfileWidget({
    super.key,
    required this.icon,
    required this.title,
    required this.txtColor,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 18.0),
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
    );
  }
}
