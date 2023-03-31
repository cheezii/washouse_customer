// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../../../components/constants/color_constants.dart';

class CenterContainer extends StatelessWidget {
  final String? thumbnail;
  final String? name;
  final num? distance;
  final num? rating;
  final GestureTapCallback press;
  final bool hasRating;
  const CenterContainer({
    Key? key,
    this.thumbnail,
    this.name,
    this.distance,
    this.rating,
    required this.press,
    required this.hasRating,
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
                    child: Image.network(thumbnail!),
                  ),
                ),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name!,
                      style: const TextStyle(
                          fontWeight: FontWeight.w600, fontSize: 18),
                    ),
                    const SizedBox(height: 3),
                    Row(
                      children: [
                        Text('$distance km'),
                        const SizedBox(width: 5),
                        hasRating
                            ? Row(
                                children: [
                                  const Icon(Icons.circle_rounded, size: 5),
                                  const SizedBox(width: 5),
                                  const Icon(Icons.star_rounded,
                                      color: kPrimaryColor),
                                  Text('$rating'),
                                ],
                              )
                            : Container(),
                      ],
                    ),
                    const SizedBox(height: 3),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: kPrimaryColor),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(6),
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
