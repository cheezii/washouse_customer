import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:washouse_customer/screens/profile/components/manage_account_widget.dart';
import 'package:washouse_customer/screens/profile/components/profile_widget.dart';

import '../../components/constants/color_constants.dart';
import 'general_information_screen.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: textColor,
            size: 22,
          ),
        ),
        centerTitle: true,
        title: const Text('Về chúng tôi',
            style: TextStyle(color: textColor, fontSize: 24)),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Column(
          children: [
            ProfileWidget(
              icon: Icons.info_outline_rounded,
              title: 'Thông tin chung',
              txtColor: textColor,
              iconColor: textColor,
              press: () {
                Navigator.push(
                    context,
                    PageTransition(
                        child: const GeneralInformation(),
                        type: PageTransitionType.rightToLeftWithFade));
              },
            ),
            const SizedBox(height: 10),
            ProfileWidget(
              icon: Icons.article_outlined,
              title: 'Điều khoản sử dụng',
              txtColor: textColor,
              iconColor: textColor,
              press: () {},
            ),
            const SizedBox(height: 10),
            ProfileWidget(
              icon: Icons.privacy_tip_outlined,
              title: 'Chính sách bảo mật',
              txtColor: textColor,
              iconColor: textColor,
              press: () {},
            ),
          ],
        ),
      ),
    );
  }
}
