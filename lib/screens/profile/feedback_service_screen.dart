import 'package:flutter/material.dart';
import 'package:washouse_customer/resource/models/feedback.dart';
import 'package:washouse_customer/screens/profile/components/no_feedback.dart';

import '../feedback/component/feedback_widget.dart';

class FeedbackToServiceScreen extends StatefulWidget {
  const FeedbackToServiceScreen({super.key});

  @override
  State<FeedbackToServiceScreen> createState() =>
      _FeedbackToServiceScreenState();
}

class _FeedbackToServiceScreenState extends State<FeedbackToServiceScreen> {
  bool isMore = false;

  @override
  Widget build(BuildContext context) {
    if (demoFeedbackList.isEmpty) {
      return const NoFeedbackScreen(type: 'trung tâm');
    } else {
      return ListView.separated(
        padding: const EdgeInsets.only(bottom: 8.0, top: 8.0),
        itemCount: demoFeedbackList.length,
        itemBuilder: ((context, index) {
          return FeedbackWidget(
            avatar: demoFeedbackList[index].avatar,
            name: demoFeedbackList[index].name,
            date: demoFeedbackList[index].date,
            content: demoFeedbackList[index].content,
            rating: demoFeedbackList[index].rating,
            press: () => setState(() {
              isMore = !isMore;
            }),
            isLess: isMore,
          );
        }),
        separatorBuilder: (context, index) {
          return Divider(
            thickness: 1,
            color: Colors.grey.shade300,
          );
        },
      );
    }
  }
}
