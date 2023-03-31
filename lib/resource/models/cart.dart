// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:washouse_customer/resource/models/service.dart';

class Cart {
  Service service;
  ValueNotifier<int> numOfItems;
  Cart({
    required this.service,
    required this.numOfItems,
  });
}

// List<Cart> demoCarts = [
//   Cart(service: demoServices[0], numOfItems: ValueNotifier<int>(1)),
//   Cart(service: demoServices[1], numOfItems: ValueNotifier<int>(3)),
//   Cart(service: demoServices[2], numOfItems: ValueNotifier<int>(2)),
// ];
