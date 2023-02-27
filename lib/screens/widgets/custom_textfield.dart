import 'package:flutter/material.dart';

import '../../constants/colors/color_constants.dart';

class CustomTextfield extends StatelessWidget {
  final IconData icon;
  final bool obsecureText;
  final String hintText;
  final TextInputType inputType;

  const CustomTextfield({
    super.key,
    required this.icon,
    required this.obsecureText,
    required this.hintText,
    required this.inputType,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: obsecureText,
      style: const TextStyle(
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
      keyboardType: inputType,
    );
  }
}
