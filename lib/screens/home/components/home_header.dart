import 'package:flutter/material.dart';

import '../../../components/constants/color_constants.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: const [
                  Icon(
                    Icons.location_on_rounded,
                    color: kPrimaryColor,
                  ),
                  SizedBox(width: 6),
                  Text(
                    '477 Man Thiện',
                    style: TextStyle(
                      color: textColor,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const Icon(
                Icons.notifications,
                color: textColor,
                size: 30.0,
              ),
            ],
          ),
          const SizedBox(height: 8),
          Container(
            height: 40,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(30),
            ),
            child: const TextField(
              decoration: InputDecoration(
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                hintText: 'Tìm kiếm tiệm giặt',
                prefixIcon: Icon(Icons.search_rounded),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
