import 'package:flutter/material.dart';

import '../../../components/constants/color_constants.dart';

class ListCenter extends StatelessWidget {
  final String thumbnail;
  final String name;
  final double distance;
  final double rating;
  final GestureTapCallback press;
  const ListCenter({
    Key? key,
    required this.thumbnail,
    required this.name,
    required this.distance,
    required this.rating,
    required this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Column(
        children: [
          Row(
            children: [
              SizedBox(
                width: 100,
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Image.asset(thumbnail),
                  ),
                ),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                          fontWeight: FontWeight.w600, fontSize: 18),
                    ),
                    const SizedBox(height: 3),
                    Row(
                      children: [
                        Text('$distance km'),
                        const SizedBox(width: 5),
                        const Icon(Icons.circle_rounded, size: 5),
                        const SizedBox(width: 5),
                        const Icon(Icons.star_rounded, color: kPrimaryColor),
                        Text('$rating')
                      ],
                    ),
                    const SizedBox(height: 3),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: kPrimaryColor),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(8),
                        child: Text('Giặt hấp'),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
