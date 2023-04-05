import 'package:flutter/services.dart';

class MaxValueFormatter extends TextInputFormatter {
  final double maxValue;

  MaxValueFormatter(this.maxValue);

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (double.parse(newValue.text) > maxValue) {
      return oldValue;
    }
    return newValue;
  }
}
