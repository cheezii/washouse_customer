// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../../components/constants/color_constants.dart';

class FeedbackWidget extends StatelessWidget {
  final String avatar;
  final String name;
  final String date;
  final String content;
  final int rating;
  final bool isLess;
  final GestureTapCallback press;
  const FeedbackWidget({
    Key? key,
    required this.avatar,
    required this.name,
    required this.date,
    required this.content,
    required this.rating,
    required this.isLess,
    required this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 45.0,
            width: 45.0,
            margin: const EdgeInsets.only(right: 16.0),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(avatar),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(44.0),
            ),
          ),
          const SizedBox(height: 8.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 10),
              RatingBarIndicator(
                rating: rating.toDouble(),
                itemBuilder: (context, index) => const Icon(
                  Icons.star,
                  color: kPrimaryColor,
                ),
                itemCount: 5,
                itemSize: 20,
                direction: Axis.horizontal,
              ),
              const SizedBox(height: 10),
              Text(
                date,
                style: TextStyle(fontSize: 14.0, color: Colors.grey.shade600),
              ),
              const SizedBox(height: 10),
              GestureDetector(
                onTap: press,
                child: isLess
                    ? SizedBox(
                        width: MediaQuery.of(context).size.width * .74,
                        child: Text(
                          content,
                          style: const TextStyle(
                            fontSize: 17,
                            color: textColor,
                          ),
                        ),
                      )
                    : SizedBox(
                        width: MediaQuery.of(context).size.width * .7,
                        child: Text(
                          content,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 17,
                            color: textColor,
                          ),
                        ),
                      ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
