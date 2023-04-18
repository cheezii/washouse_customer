import 'package:flutter/material.dart';
import 'package:washouse_customer/resource/models/feedback.dart';
import 'package:washouse_customer/screens/profile/components/no_feedback.dart';

import '../feedback/component/feedback_widget.dart';

class FeedbackToServiceScreen extends StatefulWidget {
  final List<FeedbackModel> list;
  final String name;
  final String avatar;
  const FeedbackToServiceScreen({super.key, required this.list, required this.name, required this.avatar});

  @override
  State<FeedbackToServiceScreen> createState() => _FeedbackToServiceScreenState();
}

class _FeedbackToServiceScreenState extends State<FeedbackToServiceScreen> {
  bool isMore = false;

  @override
  Widget build(BuildContext context) {
    if (widget.list.isEmpty) {
      return const NoFeedbackScreen(type: 'trung tâm');
    } else {
      return ListView.separated(
        padding: const EdgeInsets.only(bottom: 8.0, top: 8.0),
        itemCount: widget.list.length,
        itemBuilder: ((context, index) {
          return FeedbackWidget(
            avatar: widget.avatar,
            name: widget.name,
            date: widget.list[index].createdDate!,
            content: widget.list[index].content!,
            rating: widget.list[index].rating!,
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
