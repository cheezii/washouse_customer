import 'package:flutter/material.dart';
import 'package:washouse_customer/constants/color_constants.dart';
import 'package:washouse_customer/models/category.dart';
import 'package:washouse_customer/screens/home/components/post_card.dart';

import '../../constants/size.dart';
import '../../models/post.dart';
import '../widgets/search_field.dart';
import 'components/category_card.dart';
import 'components/title_with_more_button.dart';

class Homescreen extends StatelessWidget {
  const Homescreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Column(
          children: const [
            AppBar(),
            Body(),
          ],
        ),
      ),
    );
  }
}

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TitleWithMoreBtn(
          title: 'Dịch vụ',
          press: () {},
        ),
        GridView.builder(
          shrinkWrap: true,
          itemCount: categoryList.length,
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 8,
          ),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.8,
            crossAxisSpacing: 20,
            mainAxisSpacing: 24,
          ),
          itemBuilder: (context, index) {
            return CategoryCard(
              category: categoryList[index],
            );
          },
        ),
        TitleWithMoreBtn(
          title: 'Bài đăng',
          press: () {},
        ),
        GridView.builder(
          shrinkWrap: true,
          itemCount: postList.length,
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 8,
          ),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.6,
            crossAxisSpacing: 20,
            mainAxisSpacing: 24,
          ),
          itemBuilder: (context, index) {
            return PostCard(
              post: postList[index],
            );
          },
        ),
      ],
    );
  }
}

class AppBar extends StatelessWidget {
  const AppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
      height: 200,
      width: double.infinity,
      decoration: const BoxDecoration(
        color: kPrimaryColor,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(36),
          bottomRight: Radius.circular(36),
        ),
      ),
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
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: const [
                      Icon(
                        Icons.location_on_rounded,
                        color: Color.fromARGB(255, 98, 205, 255),
                      ),
                      Text(
                        '477 Man Thiện, Tăng Nhơn Phú A',
                        style: TextStyle(
                          color: Colors.white,
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
          const SizedBox(height: kDefaultPadding),
          const SearchTextField(
            searchString: 'Tìm tiệm giặt',
            suffixIcon: Icons.filter_alt_rounded,
          ),
        ],
      ),
    );
  }
}
