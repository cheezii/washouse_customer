import 'package:flutter/material.dart';

import '../../constants/color_constants.dart';

class CustomTextfield extends StatefulWidget {
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
  State<CustomTextfield> createState() => _CustomTextfieldState();
}

class _CustomTextfieldState extends State<CustomTextfield> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: widget.obsecureText,
      style: const TextStyle(
        color: textColor,
      ),
      decoration: InputDecoration(
        border: InputBorder.none,
        prefixIcon: Icon(
          widget.icon,
          color: textColor.withOpacity(.5),
        ),
        labelText: widget.hintText,
      ),
      cursorColor: textColor.withOpacity(.8),
      keyboardType: widget.inputType,
    );
  }
}
