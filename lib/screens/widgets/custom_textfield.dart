import 'package:flutter/material.dart';

import '../../constants.dart';

class CustomTextfield extends StatelessWidget {
  final IconData icon;
  final bool obsecureText;
  final String hintText;

  const CustomTextfield({
    super.key,
    required this.icon,
    required this.obsecureText,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: obsecureText,
      style: TextStyle(
        color: textColor,
      ),
      decoration: InputDecoration(
        border: InputBorder.none,
        prefixIcon: Icon(
          icon,
          color: textColor.withOpacity(.5),
        ),
        labelText: hintText,
      ),
      cursorColor: textColor.withOpacity(.8),
    );
  }
}
