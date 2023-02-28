import 'package:flutter/material.dart';

import '../../../constants/color_constants.dart';

class ProfileWidget extends StatelessWidget {
  final IconData icon;
  final String title;
  const ProfileWidget({
    super.key,
    required this.icon,
    required this.title,
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
                color: textColor.withOpacity(.6),
                size: 26.0,
              ),
              const SizedBox(width: 16),
              Text(
                title,
                style: const TextStyle(
                  color: textColor,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              )
            ],
          ),
          Icon(
            Icons.arrow_forward_ios,
            color: textColor.withOpacity(.5),
            size: 18.0,
          ),
        ],
      ),
    );
  }
}
