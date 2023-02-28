import 'package:flutter/material.dart';
import 'package:washouse_customer/constants/color_constants.dart';
import 'package:washouse_customer/constants/size.dart';

import 'components/profile_widget.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
              height: 125,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        'Tài khoản',
                        style: TextStyle(
                          color: textColor,
                          fontWeight: FontWeight.w500,
                          fontSize: 24,
                        ),
                      ),
                      Icon(
                        Icons.notifications,
                        color: textColor,
                        size: 30.0,
                      ),
                    ],
                  )
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(kDefaultPadding),
              height: size.height,
              width: size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 150,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: kPrimaryColor.withOpacity(.5),
                        width: 5.0,
                      ),
                    ),
                    child: const CircleAvatar(
                      radius: 60,
                      backgroundColor: Colors.grey,
                      backgroundImage: ExactAssetImage(
                          'assets/images/profile/anonymous.jpg'),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Lê Thành Đạt',
                    style: TextStyle(
                      color: textColor,
                      fontSize: 22,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Text(
                    'datlt3001@gmail.com',
                    style: TextStyle(
                      color: textColor.withOpacity(.5),
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 30),
                  SizedBox(
                    height: size.height * .7,
                    width: size.width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const [
                        ProfileWidget(
                            icon: Icons.person, title: 'Hồ sơ của tôi'),
                        ProfileWidget(
                            icon: Icons.feedback_rounded, title: 'Đánh giá'),
                        ProfileWidget(
                            icon: Icons.help_rounded,
                            title: 'Trung tâm hỗ trợ'),
                        ProfileWidget(
                            icon: Icons.info_outline_rounded,
                            title: 'Về chúng tôi'),
                        ProfileWidget(
                            icon: Icons.logout_rounded, title: 'Đăng xuất'),
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
