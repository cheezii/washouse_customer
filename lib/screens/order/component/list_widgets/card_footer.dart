// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:washouse_customer/resource/models/response_models/order_item_list.dart';
import 'package:washouse_customer/screens/profile/my_feed_back_screen.dart';

import '../../../../components/constants/color_constants.dart';
import '../../../feedback/write_feedback_screen.dart';
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
        (orderItem.status!.trim().toLowerCase() == 'completed')
            //&& orderItem.isFeedback == false)
            ?
            // GestureDetector(
            //     onTap: () {
            //       Navigator.push(
            //           context,
            //           PageTransition(
            //               child: FeedbackOrderScreen(orderItem: orderItem),
            //               type: PageTransitionType.fade));
            //     },
            //     child: Container(
            //       alignment: Alignment.bottomRight,
            //       decoration: BoxDecoration(
            //         border: Border.all(color: kPrimaryColor),
            //         borderRadius: BorderRadius.circular(20),
            //         color: kPrimaryColor,
            //       ),
            //       child: const Padding(
            //         padding:
            //             EdgeInsets.only(top: 9, bottom: 9, right: 20, left: 20),
            //         child: Text(
            //           'Viết đánh giá',
            //           style: TextStyle(color: Colors.white),
            //         ),
            //       ),
            //     ),
            //   )
            orderItem.isFeedback == false
                ? ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          PageTransition(
                              child: FeedbackOrderScreen(orderItem: orderItem),
                              type: PageTransitionType.fade));
                    },
                    style: ElevatedButton.styleFrom(
                        padding: const EdgeInsetsDirectional.symmetric(
                            horizontal: 20, vertical: 9),
                        //foregroundColor: kPrimaryColor.withOpacity(.7),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                          side:
                              const BorderSide(color: kPrimaryColor, width: 1),
                        ),
                        backgroundColor: kPrimaryColor),
                    child: const Text(
                      'Viết đánh giá',
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                : ElevatedButton(
                    onPressed: () {
                      // Navigator.push(
                      //     context,
                      //     PageTransition(
                      //         child: FeedbackOrderScreen(orderItem: orderItem),
                      //         type: PageTransitionType.fade));
                      Navigator.push(
                          context,
                          PageTransition(
                              child: MyFeedbackScreen(),
                              type: PageTransitionType.fade));
                    },
                    style: ElevatedButton.styleFrom(
                        padding: const EdgeInsetsDirectional.symmetric(
                            horizontal: 20, vertical: 9),
                        //foregroundColor: kPrimaryColor.withOpacity(.7),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                          side:
                              const BorderSide(color: kPrimaryColor, width: 1),
                        ),
                        backgroundColor: Colors.white),
                    child: Text(
                      'Xem đánh giá',
                      style: const TextStyle(color: kPrimaryColor),
                    ),
                  )
            : SizedBox.shrink(),
        // (orderItem.status!.trim().toLowerCase() == 'ready' &&
        //         orderItem.isPayment == false)
        //     ?
        //     // GestureDetector(
        //     //     onTap: () {
        //     //       Navigator.push(
        //     //           context,
        //     //           PageTransition(
        //     //               child: OrderDetailScreen(
        //     //                 orderId: orderItem.orderId!,
        //     //                 isPayment: orderItem.isPayment!,
        //     //                 status: orderItem.status!.toLowerCase(),
        //     //               ),
        //     //               type: PageTransitionType.rightToLeftWithFade));
        //     //     },
        //     //     child: Container(
        //     //       alignment: Alignment.bottomRight,
        //     //       decoration: BoxDecoration(
        //     //         border: Border.all(color: kPrimaryColor),
        //     //         borderRadius: BorderRadius.circular(20),
        //     //         color: kPrimaryColor,
        //     //       ),
        //     //       child: const Padding(
        //     //         padding:
        //     //             EdgeInsets.only(top: 9, bottom: 9, right: 20, left: 20),
        //     //         child: Text(
        //     //           'Thanh toán bằng ví',
        //     //           style: TextStyle(color: Colors.white),
        //     //         ),
        //     //       ),
        //     //     ),
        //     //   )
        //     // ElevatedButton(
        //     //     onPressed: () {
        //     //       Navigator.push(
        //     //           context,
        //     //           PageTransition(
        //     //               child: OrderDetailScreen(
        //     //                 orderId: orderItem.orderId!,
        //     //                 isPayment: orderItem.isPayment!,
        //     //                 status: orderItem.status!.toLowerCase(),
        //     //               ),
        //     //               type: PageTransitionType.rightToLeftWithFade));
        //     //     },
        //     //     style: ElevatedButton.styleFrom(
        //     //         padding: const EdgeInsetsDirectional.symmetric(
        //     //             horizontal: 20, vertical: 9),
        //     //         //foregroundColor: kPrimaryColor.withOpacity(.7),
        //     //         elevation: 0,
        //     //         shape: RoundedRectangleBorder(
        //     //           borderRadius: BorderRadius.circular(20),
        //     //           side: BorderSide(color: kPrimaryColor, width: 1),
        //     //         ),
        //     //         backgroundColor: kPrimaryColor),
        //     //     child:
        //     const Text(
        //         'Chưa thanh toán',
        //         style: TextStyle(color: Colors.white),
        //       )
        //     //)
        //     : Container(),
        (orderItem.status!.trim().toLowerCase() == 'ready' &&
                orderItem.isPayment == true)
            ?
            // GestureDetector(
            //     onTap: () {
            //       Navigator.push(
            //           context,
            //           PageTransition(
            //               child: OrderDetailScreen(
            //                 orderId: orderItem.orderId!,
            //                 isPayment: orderItem.isPayment!,
            //                 status: orderItem.status!.toLowerCase(),
            //               ),
            //               type: PageTransitionType.rightToLeftWithFade));
            //     },
            //     child: Container(
            //       alignment: Alignment.bottomRight,
            //       decoration: BoxDecoration(
            //         border: Border.all(color: kPrimaryColor),
            //         borderRadius: BorderRadius.circular(20),
            //       ),
            //       child: const Padding(
            //         padding:
            //             EdgeInsets.only(top: 9, bottom: 9, right: 20, left: 20),
            //         child:
            const Text(
                'Đã thanh toán',
                style: TextStyle(color: textColor),
              )
            : (orderItem.status!.trim().toLowerCase() == 'ready' &&
                    orderItem.isPayment == false)
                ? const Text(
                    'Chưa thanh toán',
                    style: TextStyle(color: textColor),
                  )
                //   ),
                // ),
                //)
                : Container(),
        (orderItem.status!.trim().toLowerCase() == 'pending' ||
                orderItem.status!.trim().toLowerCase() == 'confirmed')
            ?
            // GestureDetector(
            //     onTap: () {
            //       Navigator.push(
            //           context,
            //           PageTransition(
            //               child: OrderDetailScreen(
            //                 orderId: orderItem.orderId!,
            //                 isPayment: orderItem.isFeedback!,
            //                 status: orderItem.status!.toLowerCase(),
            //               ),
            //               type: PageTransitionType.rightToLeftWithFade));
            //     },
            //     child: Container(
            //       alignment: Alignment.bottomRight,
            //       decoration: BoxDecoration(
            //         border: Border.all(color: cancelledColor),
            //         borderRadius: BorderRadius.circular(20),
            //         color: cancelledColor,
            //       ),
            //       child: const Padding(
            //         padding:
            //             EdgeInsets.only(top: 9, bottom: 9, right: 20, left: 20),
            //         child: Text(
            //           'Hủy đơn',
            //           style: TextStyle(color: Colors.white),
            //         ),
            //       ),
            //     ),
            //   )
            ElevatedButton(
                onPressed: () {
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
                style: ElevatedButton.styleFrom(
                    padding: const EdgeInsetsDirectional.symmetric(
                        horizontal: 20, vertical: 9),
                    //foregroundColor: cancelledColor.withOpacity(.5),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: BorderSide(color: cancelledColor, width: 1),
                    ),
                    backgroundColor: cancelledColor),
                child: const Text(
                  'Hủy dịch vụ',
                  style: TextStyle(color: Colors.white),
                ),
              )
            : Container(),
        const Spacer(),
        orderItem.status!.trim().toLowerCase() == 'cancelled'
            ?
            // GestureDetector(
            //     // onTap: () {
            //     //   Navigator.push(context, PageTransition(child: CancelDetailScreen(orderId: orderItem.orderId!), type: PageTransitionType.rightToLeftWithFade));
            //     // },
            //     onTap: () => Navigator.pushNamed(
            //       context,
            //       '/cancelDetailScreen',
            //       arguments: orderItem.orderId!,
            //     ),
            //     child: Container(
            //       alignment: Alignment.bottomRight,
            //       decoration: BoxDecoration(
            //         border: Border.all(color: cancelledColor),
            //         borderRadius: BorderRadius.circular(20),
            //       ),
            //       child: Padding(
            //         padding: const EdgeInsets.only(
            //             top: 9, bottom: 9, right: 20, left: 20),
            //         child: Text(
            //           'Chi tiết đơn hủy',
            //           style: TextStyle(color: cancelledColor),
            //         ),
            //       ),
            //     ),
            //   )
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                      side: BorderSide(color: cancelledColor, width: 1),
                    ),
                    backgroundColor: Colors.white),
                onPressed: () => Navigator.pushNamed(
                  context,
                  '/cancelDetailScreen',
                  arguments: orderItem.orderId!,
                ),
                child: Text(
                  'Chi tiết đơn hủy',
                  style: TextStyle(color: cancelledColor),
                ),
              )
            :
            // GestureDetector(
            //     onTap: () {
            //       Navigator.push(
            //           context,
            //           PageTransition(
            //               child: OrderDetailScreen(
            //                 orderId: orderItem.orderId!,
            //                 isPayment: orderItem.isFeedback!,
            //                 status: orderItem.status!.toLowerCase(),
            //               ),
            //               type: PageTransitionType.rightToLeftWithFade));
            //     },
            //     child: Container(
            //       alignment: Alignment.bottomRight,
            //       decoration: BoxDecoration(
            //         border: Border.all(color: kPrimaryColor),
            //         borderRadius: BorderRadius.circular(20),
            //       ),
            //       child: const Padding(
            //         padding:
            //             EdgeInsets.only(top: 9, bottom: 9, right: 20, left: 20),
            //         child: Text('Xem chi tiết'),
            //       ),
            //     ),
            //   ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                      side: const BorderSide(color: kPrimaryColor, width: 1),
                    ),
                    backgroundColor: Colors.white),
                onPressed: () {
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
                child: const Text(
                  'Xem chi tiết',
                  style: TextStyle(color: kPrimaryColor),
                ),
              ),
      ],
    );
  }
}
