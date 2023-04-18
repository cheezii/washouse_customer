// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:washouse_customer/screens/feedback/component/feedback_widget.dart';
import 'package:washouse_customer/screens/profile/components/no_feedback.dart';

import '../../resource/models/feedback.dart';

class FeedbackToCenterScreen extends StatefulWidget {
  final List<FeedbackModel> list;
  final String name;
  final String avatar;
  const FeedbackToCenterScreen({super.key, required this.list, required this.name, required this.avatar});

  @override
  State<FeedbackToCenterScreen> createState() => _FeedbackToCenterScreenState();
}

class _FeedbackToCenterScreenState extends State<FeedbackToCenterScreen> {
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
