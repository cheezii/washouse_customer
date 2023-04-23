import 'package:flutter/material.dart';

import '../../../components/constants/color_constants.dart';

class StepFlowWidget extends StatelessWidget {
  final String step;
  final String image;
  final String content;
  const StepFlowWidget({super.key, required this.step, required this.image, required this.content});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            step,
            style: const TextStyle(
              color: textBoldColor,
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Image.asset(image),
          const SizedBox(height: 8),
          Text(
            content,
            style: const TextStyle(
              color: textColor,
              fontSize: 16,
            ),
            textAlign: TextAlign.justify,
          )
        ],
      ),
    );
  }
}
