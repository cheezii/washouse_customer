import 'package:flutter/material.dart';
import 'package:washouse_customer/constants/colors/color_constants.dart';

class Homescreen extends StatelessWidget {
  const Homescreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
          child: Column(
            children: [
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Địa chỉ hiện tại',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: const [
                          Icon(
                            Icons.location_on_rounded,
                            color: kPrimaryColor,
                          ),
                          Text(
                            '477 Man Thiện, Tăng Nhơn Phú A',
                            style: TextStyle(
                              color: textBoldColor,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      )
                    ],
                  )
                ],
              ),
              const SizedBox(height: 15),
              Row(
                children: [
                  Container(
                    height: 50,
                    width: size.width * 0.75,
                    padding: const EdgeInsets.all(15.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Row(
                      children: const [
                        Icon(
                          Icons.search_rounded,
                          color: kPrimaryColor,
                          size: 25,
                        ),
                        SizedBox(width: 15),
                        Text(
                          'Tìm kiếm tiệm giặt',
                          style: TextStyle(
                            fontWeight: FontWeight.w300,
                            fontSize: 16.0,
                            color: textNoteColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  Container(
                    height: 50,
                    width: 50,
                    decoration: const BoxDecoration(
                      color: kPrimaryColor,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.filter_alt_rounded,
                        color: Colors.white),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
