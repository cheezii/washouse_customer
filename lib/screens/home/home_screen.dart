import 'package:flutter/material.dart';
import 'package:washouse_customer/constants/colors/color_constants.dart';

class Homescreen extends StatelessWidget {
  const Homescreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home screen'),
        backgroundColor: kPrimaryColor,
      ),
    );
  }
}
