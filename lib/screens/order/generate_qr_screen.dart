// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../components/constants/color_constants.dart';

class GenerateQRCodeScreen extends StatelessWidget {
  final orderID;
  const GenerateQRCodeScreen({
    Key? key,
    required this.orderID,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var qrData = orderID as String;
    Size size = MediaQuery.of(context).size;
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
          child: Text('QR đơn hàng', style: TextStyle(color: textColor, fontSize: 27)),
        ),
        actions: [
          GestureDetector(
            onTap: () {},
            child: const Padding(
              padding: EdgeInsets.only(right: 16),
              child: Icon(
                Icons.search_rounded,
                color: kBackgroundColor,
                size: 30,
              ),
            ),
          ),
        ],
      ),
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 100),
            QrImage(data: qrData, size: 0.5 * size.width),
            const SizedBox(height: 10),
            const Text(
              'Bạn đã đặt hàng thành công!',
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 22, color: kPrimaryColor),
            ),
            const SizedBox(height: 10),
            const Text(
              'Đưa mã QR cho nhân viên khi mang đồ đến trung tâm để xác nhận đơn hàng',
              style: TextStyle(fontSize: 17),
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }
}
