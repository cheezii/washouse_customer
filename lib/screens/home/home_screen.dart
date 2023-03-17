// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import 'package:washouse_customer/components/constants/color_constants.dart';
import 'package:washouse_customer/models/category.dart';
import '../../models/center.dart';
import '../../models/post.dart';
import '../center/list_center_screen.dart';
import 'components/category_card.dart';
import 'components/home_header.dart';

class Homescreen extends StatelessWidget {
  const Homescreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              const HomeHeader(),
              const SizedBox(height: 10),
              Divider(thickness: 1, color: Colors.grey.shade300),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Các loại dịch vụ',
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.w700),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.arrow_forward_ios_rounded,
                            size: 20,
                          ),
                        )
                      ],
                    ),
                    GridView.builder(
                      shrinkWrap: true,
                      itemCount: 12,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                        childAspectRatio: 0.8,
                        crossAxisSpacing: 15,
                        mainAxisSpacing: 15,
                      ),
                      itemBuilder: ((context, index) {
                        return CategoryCard(
                          icon: categoryList[index].thumbnail,
                          text: categoryList[index].name,
                          press: () {},
                        );
                      }),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Divider(thickness: 8, color: Colors.grey.shade200),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Tiệm giặt gần đây',
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.w700),
                        ),
                        IconButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                PageTransition(
                                    child: const ListCenterScreen(),
                                    type: PageTransitionType
                                        .rightToLeftWithFade));
                          },
                          icon: const Icon(
                            Icons.arrow_forward_ios_rounded,
                            size: 20,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: size.height * .28,
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: centerList.length,
                        itemBuilder: ((context, index) {
                          return GestureDetector(
                            onTap: () {},
                            child: Container(
                              width: 150,
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  AspectRatio(
                                    aspectRatio: 1,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Image.asset(
                                          centerList[index].image[0]),
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    centerList[index].centerName,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 18),
                                  ),
                                  Text(
                                    centerList[index].location,
                                    style:
                                        TextStyle(color: Colors.grey.shade600),
                                  ),
                                  Row(
                                    children: [
                                      Text('${centerList[index].distance} km'),
                                      const SizedBox(width: 5),
                                      const Icon(Icons.circle_rounded, size: 5),
                                      const SizedBox(width: 5),
                                      const Icon(Icons.star_rounded,
                                          color: kPrimaryColor),
                                      Text('${centerList[index].rating}')
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Divider(thickness: 8, color: Colors.grey.shade200),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Blog tiệm giặt',
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.w700),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.arrow_forward_ios_rounded,
                            size: 20,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: size.height * .3,
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: postList.length,
                        itemBuilder: ((context, index) {
                          return Container(
                            width: 200,
                            margin: const EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Column(
                              children: [
                                AspectRatio(
                                  aspectRatio: 1,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child:
                                        Image.asset(postList[index].thumbnail),
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  postList[index].title,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18),
                                )
                              ],
                            ),
                          );
                        }),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
