// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:washouse_customer/resource/models/response_models/order_item_list.dart';

import '../../../../components/constants/color_constants.dart';
import '../../../feedback/feedback_screen.dart';
import '../../cancel_detail_screen.dart';
import '../../order_detail_screen.dart';

class CardFooter extends StatelessWidget {
  Order_Item orderItem;
  CardFooter({
    Key? key,
    required this.orderItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        (orderItem.status!.trim().toLowerCase() == 'completed' && orderItem.isFeedback == false)
            ? GestureDetector(
                onTap: () {
                  Navigator.push(context, PageTransition(child: FeedbackOrderScreen(orderItem: orderItem), type: PageTransitionType.fade));
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
        (orderItem.status!.trim().toLowerCase() == 'completed' && orderItem.isFeedback == true)
            ? GestureDetector(
                onTap: () {
                  Navigator.push(context, PageTransition(child: FeedbackOrderScreen(orderItem: orderItem), type: PageTransitionType.fade));
                },
                child: Container(
                  alignment: Alignment.bottomRight,
                  decoration: BoxDecoration(
                    border: Border.all(color: kPrimaryColor),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.only(top: 9, bottom: 9, right: 20, left: 20),
                    child: Text('Xem đánh giá'),
                  ),
                ),
              )
            : Container(),
        orderItem.status!.trim().toLowerCase() == 'cancelled'
            ? Text(
                'Đã huỷ',
                style: TextStyle(color: cancelledColor),
              )
            : Container(),
        (orderItem.status!.trim().toLowerCase() == 'ready' && orderItem.isPayment == false)
            ? GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      PageTransition(
                          child: OrderDetailScreen(
                            orderId: orderItem.orderId!,
                            isPayment: orderItem.isPayment!,
                            status: orderItem.status!.toLowerCase(),
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
                    child: Text(
                      'Thanh toán bằng ví',
                      style: TextStyle(color: textColor),
                    ),
                  ),
                ),
              )
            : Container(),
        (orderItem.status!.trim().toLowerCase() == 'ready' && orderItem.isPayment == true)
            ? GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      PageTransition(
                          child: OrderDetailScreen(
                            orderId: orderItem.orderId!,
                            isPayment: orderItem.isPayment!,
                            status: orderItem.status!.toLowerCase(),
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
                    child: Text(
                      'Đã thanh toán',
                      style: TextStyle(color: textColor),
                    ),
                  ),
                ),
              )
            : Container(),
        (orderItem.status!.trim().toLowerCase() == 'pending' || orderItem.status!.trim().toLowerCase() == 'confirmed')
            ? GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      PageTransition(
                          child: OrderDetailScreen(
                            orderId: orderItem.orderId!,
                            isPayment: orderItem.isFeedback!,
                            status: orderItem.status!.toLowerCase(),
                          ),
                          type: PageTransitionType.rightToLeftWithFade));
                },
                child: Container(
                  alignment: Alignment.bottomRight,
                  decoration: BoxDecoration(
                    border: Border.all(color: cancelledColor),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 9, bottom: 9, right: 20, left: 20),
                    child: Text(
                      'Hủy đơn',
                      style: TextStyle(color: cancelledColor),
                    ),
                  ),
                ),
              )
            : Container(),
        const Spacer(),
        orderItem.status!.trim().toLowerCase() == 'cancelled'
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
                    border: Border.all(color: cancelledColor),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 9, bottom: 9, right: 20, left: 20),
                    child: Text(
                      'Chi tiết đơn hủy',
                      style: TextStyle(color: cancelledColor),
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
                            isPayment: orderItem.isFeedback!,
                            status: orderItem.status!.toLowerCase(),
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
