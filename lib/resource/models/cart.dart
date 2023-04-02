// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:washouse_customer/resource/models/service.dart';
import 'package:washouse_customer/screens/center/component/details/category_menu.dart';

class Cart {
  ServiceDemo service;
  ValueNotifier<int> numOfItems;
  Cart({
    required this.service,
    required this.numOfItems,
  });
}

List<Cart> demoCarts = [
  Cart(service: demoServices[0], numOfItems: ValueNotifier<int>(1)),
  Cart(service: demoServices[1], numOfItems: ValueNotifier<int>(3)),
  Cart(service: demoServices[2], numOfItems: ValueNotifier<int>(2)),
];

List<ServiceDemo> demoServices = [
  ServiceDemo(
    id: 1,
    description: '1',
    name: 'Giặt sấy rèm cửa',
    image: 'assets/images/category/curtains_outlined.png',
    price: 45000,
  ),
  ServiceDemo(
    id: 2,
    description: '2',
    name: 'Giặt hấp caravat',
    image: 'assets/images/category/tie.png',
    price: 40000,
  ),
  ServiceDemo(
    id: 3,
    description: '3',
    name: 'Giặt hấp gối cổ',
    image: 'assets/images/category/neck-pillow.png',
    price: 60000,
  ),
];
