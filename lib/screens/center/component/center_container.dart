// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../../../components/constants/color_constants.dart';

class CenterContainer extends StatefulWidget {
  final String? thumbnail;
  final String? name;
  final String? address;
  final num? distance;
  final num? rating;
  final GestureTapCallback press;
  final bool hasRating;
  final bool isOpening;
  final Iterable<String?> centerCategoriesName;
  const CenterContainer({
    Key? key,
    this.thumbnail,
    this.name,
    this.address,
    this.distance,
    this.rating,
    required this.press,
    required this.hasRating,
    required this.isOpening,
    required this.centerCategoriesName,
  }) : super(key: key);

  @override
  State<CenterContainer> createState() => _CenterContainerState();
}

class _CenterContainerState extends State<CenterContainer> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.press,
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
                    child: Image.network(widget.thumbnail!),
                  ),
                ),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          Text(
                            widget.name!,
                            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                          ),
                          const SizedBox(width: 5),
                          widget.isOpening ? const Text('[Mở cửa]') : const Text('[Đóng cửa]'),
                          const SizedBox(width: 5),
                          widget.hasRating
                              ? Row(
                                  children: [
                                    const Icon(Icons.circle_rounded, size: 5),
                                    const SizedBox(width: 5),
                                    const Icon(Icons.star_rounded, color: kPrimaryColor),
                                    Text('${widget.rating}'),
                                  ],
                                )
                              : Container(),
                        ],
                      ),
                    ),
                    const SizedBox(height: 3),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          Text('${widget.distance} km'),
                          const SizedBox(width: 5),
                          const Icon(Icons.circle_rounded, size: 5),
                          const SizedBox(width: 5),
                          Text('${widget.address}'),
                        ],
                      ),
                    ),
                    const SizedBox(height: 3),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: widget.centerCategoriesName.map((categoryName) {
                          return Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  border: Border.all(color: kPrimaryColor),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(6),
                                  child: Text(categoryName!),
                                ),
                              ),
                              SizedBox(width: 5)
                            ],
                          );
                        }).toList(),
                      ),
                    )
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
