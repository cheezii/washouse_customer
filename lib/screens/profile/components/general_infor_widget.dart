import 'package:flutter/material.dart';

import '../../../components/constants/color_constants.dart';

class GeneralInformationWidget extends StatelessWidget {
  final bool isLeft;
  final String image;
  final String title;
  final String content;
  const GeneralInformationWidget({super.key, required this.isLeft, required this.image, required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      width: double.infinity,
      child: isLeft
          ? Row(
              children: [
                SizedBox(
                  height: 100,
                  width: 100,
                  child: Image.asset(image),
                ),
                const SizedBox(width: 10),
                SizedBox(
                  width: 250,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(color: textColor, fontSize: 19, fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        content,
                        style: const TextStyle(
                          color: textColor,
                          fontSize: 16,
                        ),
                        textAlign: TextAlign.justify,
                      ),
                    ],
                  ),
                ),
              ],
            )
          : Row(
              children: [
                SizedBox(
                  width: 250,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(color: textColor, fontSize: 19, fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        content,
                        style: const TextStyle(
                          color: textColor,
                          fontSize: 16,
                        ),
                        textAlign: TextAlign.justify,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                SizedBox(
                  height: 100,
                  width: 100,
                  child: Image.asset(image),
                ),
              ],
            ),
    );
  }
}
//assets/images/shopping-bag.png
//assets/images/tag.png
//assets/images/updated.png
//assets/images/coupon.png
//assets/images/search.png
