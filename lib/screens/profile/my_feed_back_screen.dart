import 'package:flutter/material.dart';
import 'package:washouse_customer/screens/profile/feedback_center_screen.dart';
import 'package:washouse_customer/screens/profile/feedback_service_screen.dart';

import '../../components/constants/color_constants.dart';

class MyFeedbackScreen extends StatefulWidget {
  const MyFeedbackScreen({super.key});

  @override
  State<MyFeedbackScreen> createState() => _MyFeedbackScreenState();
}

class _MyFeedbackScreenState extends State<MyFeedbackScreen> {
  bool isHaveFeedBack = false;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
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
              size: 24,
            ),
          ),
          centerTitle: true,
          title: const Text('Đánh giá của tôi',
              style: TextStyle(color: textColor, fontSize: 25)),
          bottom: const TabBar(
            unselectedLabelColor: textColor,
            labelColor: textColor,
            tabs: [Tab(text: 'Trung tâm'), Tab(text: 'Dịch vụ')],
          ),
        ),
        body: const TabBarView(
          children: [
            FeedbackToCenterScreen(),
            FeedbackToServiceScreen(),
          ],
        ),
      ),
    );
  }
}
