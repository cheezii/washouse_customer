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

  static String getImageOfPaymentMethod(int paymentMethod) {
    String paymentMethodString = 'assets/images/shipping/cash-on-delivery.png';
    if (paymentMethod == 1) {
      paymentMethodString = 'assets/images/shipping/vnpay-icon.png';
    } else {
      paymentMethodString = 'assets/images/shipping/cash-on-delivery.png';
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

  String mapVietnameseOrderStatus(String status) {
    if (status.trim().toLowerCase().compareTo("pending") == 0) {
      return 'Đang chờ';
    } else if (status.trim().toLowerCase().compareTo("confirmed") == 0) {
      return 'Xác nhận';
    } else if (status.trim().toLowerCase().compareTo("received") == 0) {
      return 'Đã nhận';
    } else if (status.trim().toLowerCase().compareTo("processing") == 0) {
      return 'Xử lý';
    } else if (status.trim().toLowerCase().compareTo("ready") == 0) {
      return 'Sẵn sàng';
    } else if (status.trim().toLowerCase().compareTo("completed") == 0) {
      return 'Hoàn tất';
    } else if (status.trim().toLowerCase().compareTo("cancelled") == 0) {
      return 'Đã hủy';
    } else {
      return 'Not match status';
    }
  }

  String mapVietnameseOrderDetailStatus(String status) {
    if (status.trim().toLowerCase().compareTo("pending") == 0) {
      return 'Đang chờ';
    } else if (status.trim().toLowerCase().compareTo("received") == 0) {
      return 'Đã nhận';
    } else if (status.trim().toLowerCase().compareTo("processing") == 0) {
      return 'Xử lý';
    } else if (status.trim().toLowerCase().compareTo("completed") == 0) {
      return 'Hoàn tất';
    } else if (status.trim().toLowerCase().compareTo("cancelled") == 0) {
      return 'Đã hủy';
    } else {
      return 'Not match status';
    }
  }
}
