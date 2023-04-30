import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:washouse_customer/resource/controller/base_controller.dart';
import 'package:washouse_customer/resource/controller/feedback_controller.dart';

import '../../components/constants/color_constants.dart';
import '../../resource/controller/account_controller.dart';
import '../../resource/models/center.dart';
import '../../resource/models/feedback.dart';
import '../feedback/component/feedback_widget.dart';

class CenterFeedbackScreen extends StatefulWidget {
  final LaundryCenter centerArg;
  const CenterFeedbackScreen({super.key, required this.centerArg});

  @override
  State<CenterFeedbackScreen> createState() => _CenterFeedbackScreenState();
}

class _CenterFeedbackScreenState extends State<CenterFeedbackScreen> {
  AccountController accountController = AccountController();
  BaseController baseController = BaseController();
  FeedbackController feedbackController = FeedbackController();
  List<FeedbackModel> _list = [];
  bool isLoading = false;
  void getMyFeedback() async {
    setState(() {
      isLoading = true;
    });

    try {
      print(widget.centerArg.id!);
      //List<FeedbackModel>? list = await feedbackController.getCenterFeedback(widget.centerArg.id!);
      var list =
          await feedbackController.getCenterFeedback(widget.centerArg.id!);
      print(list);
      if (list != null) {
        setState(() {
          _list = list;
          isLoading = false;
        });
      }
    } catch (e) {
      // Handle error
      setState(() {
        isLoading = false;
      });
      print('Error loading feedbacks: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    getMyFeedback();
  }

  bool isHaveFeedBack = false;
  List<double> ratings = [0, 0.1, 0.1, 0.2, 0.6];
  bool isMore = false;
  @override
  Widget build(BuildContext context) {
    List<int> CountRating = [0, 0, 0, 0, 0];
    for (var element in _list) {
      int rating = element.rating!;
      if (rating == 0) rating = 1;
      CountRating[rating - 1] = CountRating[rating - 1] + 1;
    }
    for (var i = 0; i < 5; i++) {
      ratings[i] = CountRating[i] / (_list.length);
    }
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
                            text: widget.centerArg.rating!.toString(),
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
                      rating: widget.centerArg.rating!.toDouble(),
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
                      '${widget.centerArg.numOfRating!.toString()} lượt đánh giá',
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
              itemCount: _list.length,
              itemBuilder: ((context, index) {
                return FeedbackWidget(
                  avatar:
                      'https://storage.googleapis.com/washousebucket/anonymous-20230330210147.jpg?X-Goog-Algorithm=GOOG4-RSA-SHA256&X-Goog-Credential=washouse-sa%40washouse-381309.iam.gserviceaccount.com%2F20230330%2Fauto%2Fstorage%2Fgoog4_request&X-Goog-Date=20230330T210148Z&X-Goog-Expires=1800&X-Goog-SignedHeaders=host&X-Goog-Signature=7c813f26489c9ba06cdfff27db9faa2ca4d7c046766aeb3874fdf86ec7c91ae904951f7b2617b6e78598d46f8b91d842d2f4c2a10696539bcf09c839d51d9565831f6c503b3e37f899ab8920f69c3aaa30e0ff2d9c598d1a4c523c1e8038520a32fe49a92c4448c49e602b77312444fe3505afa30da1c4bfbdf0f7a5ab9f2783005c1f3624b3417e17c0067f65f4c02fd03bbe9a0eed8390b56aa2b78a34ca88b52bbce7e1d364dc24e6650a68954e36439102f19a3b332fcb1562260d5223db1e09748eee5d7e6b0cba62dc7cfda9e1e00690f334b9e4b85c710ed77dee42759b48f98df0f05e1adf686351f6232a7d157c9f988248af0c69ec64af0cdbe247',
                  name: _list[index].createdBy!.substring(0, 6) + '********',
                  date: _list[index].createdDate!.substring(0, 10),
                  content: _list[index].content!,
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
