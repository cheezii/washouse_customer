import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../../components/constants/color_constants.dart';
import '../feedback/component/feedback_widget.dart';

class CenterFeedbackScreen extends StatefulWidget {
  const CenterFeedbackScreen({super.key});

  @override
  State<CenterFeedbackScreen> createState() => _CenterFeedbackScreenState();
}

class _CenterFeedbackScreenState extends State<CenterFeedbackScreen> {
  List<double> ratings = [0, 0.2, 0.4, 0.8, 0.7];
  bool isMore = false;
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
            size: 24,
          ),
        ),
        centerTitle: true,
        title: Text('Đánh giá trung tâm',
            style: TextStyle(color: textColor, fontSize: 27)),
      ),
      body: Column(
        children: [
          Container(
            color: Colors.grey.shade100,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: 4.toString(),
                            style: const TextStyle(
                              fontSize: 42,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const TextSpan(
                            text: " / 5",
                            style: TextStyle(
                              fontSize: 24.0,
                              color: textColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 5),
                    RatingBarIndicator(
                      rating: 4,
                      itemBuilder: (context, index) => const Icon(
                        Icons.star,
                        color: kPrimaryColor,
                      ),
                      itemCount: 5,
                      itemSize: 30,
                      direction: Axis.horizontal,
                    ),
                    const SizedBox(height: 10.0),
                    Text(
                      'Số lượt đánh giá',
                      style: const TextStyle(
                        fontSize: 18,
                        color: textColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  width: 200.0,
                  height: 120,
                  child: ListView.builder(
                    shrinkWrap: true,
                    reverse: true,
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return Row(
                        children: [
                          Text(
                            '${index + 1}',
                            style: TextStyle(fontSize: 18.0),
                          ),
                          const SizedBox(width: 4.0),
                          const Icon(Icons.star, color: kPrimaryColor),
                          const SizedBox(width: 8.0),
                          LinearPercentIndicator(
                            lineHeight: 6.0,
                            // linearStrokeCap: LinearStrokeCap.roundAll,
                            width: MediaQuery.of(context).size.width / 2.8,
                            animation: true,
                            animationDuration: 2500,
                            percent: ratings[index],
                            progressColor: kPrimaryColor,
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.only(bottom: 8.0, top: 8.0),
              itemCount: 2,
              itemBuilder: ((context, index) {
                return FeedbackWidget(
                  avatar: 'ảnh',
                  name: 'Đoàn Kim Trọng',
                  date: '27-01-2023',
                  content: 'Đánh giá',
                  rating: 4,
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
            ),
          )
        ],
      ),
    );
  }
}
