import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:washouse_customer/resource/controller/feedback_controller.dart';
import 'package:page_transition/page_transition.dart';
import 'package:washouse_customer/screens/order/order_detail_screen.dart';
import '../../components/constants/color_constants.dart';
import '../../resource/models/response_models/order_item_list.dart';

class FeedbackOrderScreen extends StatefulWidget {
  Order_Item orderItem;
  FeedbackOrderScreen({
    Key? key,
    required this.orderItem,
  }) : super(key: key);

  @override
  State<FeedbackOrderScreen> createState() => _FeedbackOrderScreen();
}

class _FeedbackOrderScreen extends State<FeedbackOrderScreen> {
  FeedbackController feedbackController = FeedbackController();
  int _rating = 0;
  String content = "";
  TextEditingController _textEditingController = TextEditingController();
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
        title: const Align(
          alignment: Alignment.center,
          child: Text('Đánh giá đơn hàng', style: TextStyle(color: textColor, fontSize: 27)),
        ),
        actions: [
          GestureDetector(
            onTap: () {},
            child: const Padding(
              padding: EdgeInsets.only(right: 16),
              child: Icon(
                Icons.filter_alt_rounded,
                color: kBackgroundColor,
                size: 30,
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 10, left: 16, right: 16),
        child: Column(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Đánh giá đơn hàng #${widget.orderItem.orderId}',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
              ],
            ),
            const SizedBox(height: 20),
            RatingBar.builder(
              itemBuilder: (context, _) => const Icon(
                Icons.star_rounded,
                color: kPrimaryColor,
              ),
              updateOnDrag: true,
              unratedColor: Colors.grey.shade300,
              minRating: 1,
              maxRating: 5,
              itemCount: 5,
              itemSize: 30,
              itemPadding: const EdgeInsets.symmetric(horizontal: 4),
              initialRating: 0,
              allowHalfRating: false, // Set this to false to allow integer ratings only
              onRatingUpdate: (rating) {
                setState(() {
                  _rating = rating.round(); // Round the rating to the nearest integer
                });
              },
            ),
            const SizedBox(height: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Nội dung đánh giá',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  maxLines: 6,
                  maxLength: 500,
                  controller: _textEditingController,
                  decoration: InputDecoration(
                    hintText: 'Nhập nội dung đánh giá',
                    contentPadding: const EdgeInsets.only(top: 8, left: 8, right: 8, bottom: 8),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      content = value;
                    });
                  },
                ),
              ],
            )
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
        height: 70,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, -15),
              blurRadius: 20,
              color: const Color(0xffdadada).withOpacity(0.15),
            ),
          ],
        ),
        child: SizedBox(
          width: 190,
          height: 40,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)), backgroundColor: kPrimaryColor),
            onPressed: (_rating == 0 || content.trim() == "")
                ? null
                : () async {
                    String message =
                        await feedbackController.createFeedbackOrder(widget.orderItem.orderId!, widget.orderItem.centerId!, content, _rating);
                    if (message == "success") {
                      // ignore: use_build_context_synchronously
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Bạn đã đánh giá đơn hàng thành công'),
                            content: Column(
                              children: [
                                SizedBox(height: 10),
                                Icon(
                                  Icons.check_circle_outline,
                                  size: 48,
                                  color: Colors.green,
                                ),
                                SizedBox(height: 10),
                                Text('Cảm ơn bạn đã đánh giá đơn hàng'),
                              ],
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  Navigator.push(
                                      context,
                                      PageTransition(
                                          child: OrderDetailScreen(
                                            orderId: widget.orderItem.orderId!,
                                            status: widget.orderItem.status!,
                                          ),
                                          type: PageTransitionType.fade));
                                },
                                child: Text('Quay lại'),
                              ),
                            ],
                          );
                        },
                      );
                    }
                  },
            child: const Text(
              'Gửi đánh giá',
              style: TextStyle(fontSize: 17),
            ),
          ),
        ),
      ),
    );
  }
}
