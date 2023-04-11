// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import 'package:washouse_customer/resource/models/order.dart';
import 'package:washouse_customer/resource/models/shipping.dart';
import 'package:washouse_customer/screens/order/component/details_widget/detail_heading.dart';

import '../../components/constants/color_constants.dart';
import 'component/details_widget/detail_service.dart';
import 'generate_qr_screen.dart';
import 'search_order_screen.dart';

class OrderDetailScreen extends StatelessWidget {
  final bool isDeliver;
  final bool isComplete;
  final bool isConfirm;
  final bool isProccessing;
  final bool isShipping;
  const OrderDetailScreen({
    Key? key,
    required this.isDeliver,
    required this.isComplete,
    required this.isConfirm,
    required this.isProccessing,
    required this.isShipping,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String status = '';
    Color statusColor = Colors.white;
    // if (orderList[0].status.compareTo('Đã hủy') == 0) {
    //   statusColor = cancelColor;
    //   status = 'Đã hủy';
    // } else if (orderList[0].status.compareTo('Xác nhận') == 0) {
    //   statusColor = confirmedColor;
    //   status = 'Xác nhận';
    // } else if (orderList[0].status.compareTo('Xử lý') == 0) {
    //   statusColor = processingColor;
    //   status = 'Xử lý';
    // } else if (orderList[0].status.compareTo('Đang chờ') == 0) {
    //   statusColor = pendingdColor;
    //   status = 'Đang chờ';
    // } else if (orderList[0].status.compareTo('Sẵn sàng') == 0) {
    //   statusColor = readyColor;
    //   status = 'Sẵn sàng';
    // } else if (orderList[0].status.compareTo('Hoàn tất') == 0) {
    //   statusColor = completeColor;
    //   status = 'Hoàn tất';
    // }
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
          child: Text('Chi tiết đơn hàng', style: TextStyle(color: textColor, fontSize: 27)),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context, PageTransition(child: const GenerateQRCodeScreen(), type: PageTransitionType.rightToLeftWithFade));
              },
              icon: const Icon(
                Icons.qr_code_2_rounded,
                color: textColor,
              ))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '#${orderList[0].id}',
                        style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
                      ),
                      //DetailHeading(statusColor: statusColor, status: status)
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    orderList[0].createdDate.toString(),
                    style: TextStyle(fontSize: 16, color: Colors.grey.shade700),
                  ),
                ],
              ),
            ),
            separateLine(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Địa chỉ người nhận',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    shipping.fullName,
                    style: const TextStyle(fontSize: 16, color: textColor),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    shipping.shippedPhone,
                    style: TextStyle(color: Colors.grey.shade600, fontSize: 16),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    shipping.shippedAddress,
                    style: TextStyle(color: Colors.grey.shade600, fontSize: 16),
                    overflow: TextOverflow.clip,
                  ),
                ],
              ),
            ),
            separateLine(),
            const DetailService(),
            separateLine(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Phương thức vận chuyển',
                    style: TextStyle(color: textColor, fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 6),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 35,
                          child: Image.asset('assets/images/shipping/ship-di.png'),
                        ),
                        const SizedBox(width: 8),
                        const Text(
                          'Không sử dụng dịch vụ vận chuyển',
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            separateLine(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Phương thức thanh toán',
                    style: TextStyle(color: textColor, fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 6),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 35,
                          child: Image.asset('assets/images/shipping/cash-on-delivery.png'),
                        ),
                        const SizedBox(width: 8),
                        const Text(
                          'Thanh toán bằng tiền mặt',
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            separateLine(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Chi tiết thanh toán',
                    style: TextStyle(color: textColor, fontSize: 18, fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text(
                              'Tạm tính:',
                              style: TextStyle(fontSize: 16),
                            ),
                            Text(
                              '285000 đ',
                              style: TextStyle(fontSize: 16, color: textColor, fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                        const SizedBox(height: 15),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text(
                              'Mã giảm giá:',
                              style: TextStyle(fontSize: 16),
                            ),
                            Text(
                              '0 đ',
                              style: TextStyle(fontSize: 16, color: textColor, fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                        const SizedBox(height: 15),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text(
                              'Phí ship:',
                              style: TextStyle(fontSize: 16),
                            ),
                            Text(
                              '0 đ',
                              style: TextStyle(fontSize: 16, color: textColor, fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                        Divider(
                          height: 40,
                          color: Colors.grey.shade300,
                          thickness: 2,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text(
                              'Tổng cộng:',
                              style: TextStyle(fontSize: 17),
                            ),
                            Text(
                              '285000 đ',
                              style: TextStyle(fontSize: 17, color: kPrimaryColor, fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20)
          ],
        ),
      ),
      bottomNavigationBar: isConfirm
          ? Container(
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
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)), backgroundColor: cancelColor),
                  onPressed: () {},
                  child: const Text(
                    'Hủy dịch vụ',
                    style: TextStyle(fontSize: 17),
                  ),
                ),
              ),
            )
          : isShipping
              ? Container(
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
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)), backgroundColor: kPrimaryColor),
                      onPressed: () {},
                      child: const Text(
                        'Thanh toán',
                        style: TextStyle(fontSize: 17),
                      ),
                    ),
                  ),
                )
              : SizedBox(width: 0, height: 0),
    );
  }

  Column separateLine() {
    return Column(
      children: [
        const SizedBox(height: 10),
        Divider(thickness: 5, color: Colors.grey.shade200),
        const SizedBox(height: 10),
      ],
    );
  }
}
