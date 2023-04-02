// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:washouse_customer/resource/models/service.dart';
import 'package:washouse_customer/screens/center/component/details/category_menu.dart';

class CartItem {
  ServiceDemo service;
  num measurement;

  CartItem({
    required this.service,
    required this.measurement,
  });

  Map<String, dynamic> toJson() => {
        'service': service,
        'measurement': measurement,
      };

  CartItem.fromJson(Map<String, dynamic> json)
      : service = json['service'],
        measurement = json['measurement'];
}

List<CartItem> demoCarts = [
  CartItem(service: demoServices[0], measurement: 1),
  CartItem(service: demoServices[1], measurement: 3),
  CartItem(service: demoServices[2], measurement: 2),
];

List<ServiceDemo> demoServices = [
  ServiceDemo(
    id: 1,
    unit: 'Kg',
    description: '1',
    name: 'Giặt sấy rèm cửa',
    image: 'assets/images/category/curtains_outlined.png',
    price: 45000,
  ),
  ServiceDemo(
    id: 2,
    unit: 'Cái',
    description: '2',
    name: 'Giặt hấp caravat',
    image: 'assets/images/category/tie.png',
    price: 40000,
  ),
  ServiceDemo(
    id: 3,
    unit: 'Đôi',
    description: '3',
    name: 'Giặt giày',
    image: 'assets/images/category/neck-pillow.png',
    price: 60000,
  ),
];
