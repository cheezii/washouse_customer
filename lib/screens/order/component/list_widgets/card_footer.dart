// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:washouse_customer/resource/models/response_models/order_item_list.dart';

import '../../../../components/constants/color_constants.dart';
import '../../../feedback/feedback_screen.dart';
import '../../cancel_detail_screen.dart';
import '../../order_detail_screen.dart';

class CardFooter extends StatelessWidget {
  final String status;
  Order_Item orderItem;
  CardFooter({
    Key? key,
    required this.status,
    required this.orderItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        status == 'Hoàn tất'
            ? GestureDetector(
                onTap: () {
                  Navigator.push(context, PageTransition(child: const FeedbackOrderScreen(), type: PageTransitionType.fade));
                },
                child: Container(
                  alignment: Alignment.bottomRight,
                  decoration: BoxDecoration(
                    border: Border.all(color: kPrimaryColor),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.only(top: 9, bottom: 9, right: 20, left: 20),
                    child: Text('Viết đánh giá'),
                  ),
                ),
              )
            : Container(),
        status == 'Đã hủy'
            ? Text(
                'Đã huỷ',
                style: TextStyle(color: cancelColor),
              )
            : Container(),
        status == 'Sẵn sàng'
            ? GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      PageTransition(
                          child: OrderDetailScreen(
                            orderId: orderItem.orderId!,
                            status: status,
                            // isDeliver: true,
                            // isComplete: isComplete,
                            // isConfirm: isPending,
                            // isProccessing: isProcessing,
                            // isShipping: isShipping,
                          ),
                          type: PageTransitionType.rightToLeftWithFade));
                },
                child: Container(
                  alignment: Alignment.bottomRight,
                  decoration: BoxDecoration(
                    border: Border.all(color: kPrimaryColor),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 9, bottom: 9, right: 20, left: 20),
                    child: Text(
                      'Thanh toán bằng ví',
                      style: TextStyle(color: textColor),
                    ),
                  ),
                ),
              )
            : Container(),
        status == 'Đang chờ'
            ? GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      PageTransition(
                          child: OrderDetailScreen(
                            orderId: orderItem.orderId!,
                            status: status,
                            // isDeliver: true,
                            // isComplete: isComplete,
                            // isConfirm: isPending,
                            // isProccessing: isProcessing,
                            // isShipping: isShipping,
                          ),
                          type: PageTransitionType.rightToLeftWithFade));
                },
                child: Container(
                  alignment: Alignment.bottomRight,
                  decoration: BoxDecoration(
                    border: Border.all(color: cancelColor),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 9, bottom: 9, right: 20, left: 20),
                    child: Text(
                      'Hủy đơn',
                      style: TextStyle(color: cancelColor),
                    ),
                  ),
                ),
              )
            : Container(),
        const Spacer(),
        status == 'Đã hủy'
            ? GestureDetector(
                // onTap: () {
                //   Navigator.push(context, PageTransition(child: CancelDetailScreen(orderId: orderItem.orderId!), type: PageTransitionType.rightToLeftWithFade));
                // },
                onTap: () => Navigator.pushNamed(
                  context,
                  '/cancelDetailScreen',
                  arguments: orderItem.orderId!,
                ),
                child: Container(
                  alignment: Alignment.bottomRight,
                  decoration: BoxDecoration(
                    border: Border.all(color: cancelColor),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 9, bottom: 9, right: 20, left: 20),
                    child: Text(
                      'Chi tiết đơn hủy',
                      style: TextStyle(color: cancelColor),
                    ),
                  ),
                ),
              )
            : GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      PageTransition(
                          child: OrderDetailScreen(
                            orderId: orderItem.orderId!,
                            status: status,
                            // isDeliver: true,
                            // isComplete: isComplete,
                            // isConfirm: isPending,
                            // isProccessing: isProcessing,
                            // isShipping: isShipping,
                          ),
                          type: PageTransitionType.rightToLeftWithFade));
                },
                child: Container(
                  alignment: Alignment.bottomRight,
                  decoration: BoxDecoration(
                    border: Border.all(color: kPrimaryColor),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.only(top: 9, bottom: 9, right: 20, left: 20),
                    child: Text('Xem chi tiết'),
                  ),
                ),
              ),
      ],
    );
  }
}
