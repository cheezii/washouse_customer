// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:washouse_customer/components/constants/color_constants.dart';
import 'package:washouse_customer/utils/price_util.dart';
import 'package:washouse_customer/utils/time_utils.dart';

class TransactionWidget extends StatefulWidget {
  final String? centerName;
  final String time;
  final double price;
  final String isAdd;
  const TransactionWidget({
    Key? key,
    this.centerName,
    required this.time,
    required this.price,
    required this.isAdd,
  }) : super(key: key);

  @override
  State<TransactionWidget> createState() => _TransactionWidgetState();
}

class _TransactionWidgetState extends State<TransactionWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            bottom: BorderSide(width: 1.0, color: Colors.grey.shade300),
          ),
        ),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Row(
                children: <Widget>[
                  SizedBox(
                    height: 40,
                    width: 40,
                    child: Image.asset(widget.isAdd.compareTo('plus') == 0
                        ? 'assets/images/transaction/wallet.png'
                        : 'assets/images/transaction/credit-card-payment.png'),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Text(
                            widget.isAdd.compareTo('plus') == 0 ? 'Nạp tiền vào ví' : widget.centerName ?? 'Trả tiền cho dịch vụ',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.grey.shade800,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 10),
                          SizedBox(
                            width: 250,
                            height: 35,
                            child: Text(
                              TimeUtils().getDisplayTime(widget.time),
                              maxLines: 2,
                              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w300, color: Colors.grey.shade600),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            Text(
              widget.isAdd.compareTo('plus') == 0
                  ? '+${PriceUtils().convertFormatPrice(widget.price.round())} đ'
                  : '-${PriceUtils().convertFormatPrice(widget.price.round())} đ',
              style: TextStyle(
                fontSize: 16,
                color: widget.isAdd.compareTo('plus') == 0 ? Colors.red : textColor,
                fontWeight: FontWeight.w500,
              ),
            )
          ],
        ),
      ),
    );
  }
}
