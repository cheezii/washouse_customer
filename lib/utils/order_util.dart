import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../resource/models/cart_item.dart';

class OrderUtils {
  static String getTextOfDeliveryType(int deliveryType) {
    String deliveryTypeString = 'Không sử dụng dịch vụ vận chuyển';
    if (deliveryType == 1) {
      deliveryTypeString = 'Vận chuyển từ bạn đến cửa hàng';
    } else if (deliveryType == 2) {
      deliveryTypeString = 'Vận chuyển từ cửa hàng đến bạn';
    } else if (deliveryType == 3) {
      deliveryTypeString = 'Vận chuyển hai chiều';
    } else {
      deliveryTypeString = 'Không sử dụng dịch vụ vận chuyển';
    }
    return deliveryTypeString;
  }

  static String getTextOfPaymentMethod(int paymentMethod) {
    String paymentMethodString = 'Thanh toán bằng tiền mặt';
    if (paymentMethod == 1) {
      paymentMethodString = 'Thanh toán qua ví';
    } else {
      paymentMethodString = 'Thanh toán bằng tiền mặt';
    }
    return paymentMethodString;
  }

  String? getTextOfFilterOrderType(String? type) {
    String? returnString = null;
    if (type == null) {
      returnString = 'orderbyme';
    } else if (type.trim().toLowerCase() == 'đặt bởi tôi') {
      returnString = 'orderbyme';
    } else if (type.trim().toLowerCase() == 'đặt hộ tôi') {
      returnString = 'orderbyanother';
    } else {
      returnString = null;
    }
    return returnString;
  }
}
