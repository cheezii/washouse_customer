import 'package:washouse_customer/resource/models/service.dart';

// class CartItem {
//   late int serviceId;
//   late int centerId;
//   late String name;
//   String? thumbnail;
//   late bool priceType;
//   double? price;
//   double? unitPrice;
//   late double measurement;
//   String? customerNote;
//   double? weight;
//   double? minPrice;
//   List<Prices>? prices;
//   String? unit;

//   CartItem(
//       {required this.serviceId,
//       required this.centerId,
//       required this.name,
//       this.thumbnail,
//       required this.priceType,
//       this.price,
//       this.unitPrice,
//       required this.measurement,
//       this.customerNote,
//       this.weight,
//       this.minPrice,
//       this.prices,
//       this.unit});

//   CartItem.fromJson(Map<String, dynamic> json) {
//     serviceId = json['serviceId'];
//     centerId = json['centerId'];
//     name = json['name'];
//     thumbnail = json['thumbnail'];
//     priceType = json['priceType'];
//     price = json['price'];
//     unitPrice = json['unitPrice'];
//     measurement = json['measurement'];
//     customerNote = json['customerNote'];
//     weight = json['weight'];
//     minPrice = json['minPrice'];
//     if (json['prices'] != null) {
//       prices = <Prices>[];
//       json['prices'].forEach((v) {
//         prices!.add(new Prices.fromJson(v));
//       });
//     }
//     unit = json['unit'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['serviceId'] = this.serviceId;
//     data['centerId'] = this.centerId;
//     data['name'] = this.name;
//     data['thumbnail'] = this.thumbnail;
//     data['price'] = this.price;
//     data['priceype'] = this.priceType;
//     data['unitPrice'] = this.unitPrice;
//     data['measurement'] = this.measurement;
//     data['customerNote'] = this.customerNote;
//     data['weight'] = this.weight;
//     data['minPrice'] = this.minPrice;
//     if (this.prices != null) {
//       data['prices'] = this.prices!.map((v) => v.toJson()).toList();
//     }
//     data['unit'] = this.unit;
//     return data;
//   }
// }

import 'dart:convert';

class CartItem {
  int serviceId;
  int centerId;
  String name;
  String? thumbnail;
  bool priceType;
  double? price;
  double? unitPrice;
  double measurement;
  String? customerNote;
  double? weight;
  double? minPrice;
  List<Prices>? prices;
  String? unit;

  CartItem({
    required this.serviceId,
    required this.centerId,
    required this.name,
    required this.priceType,
    required this.measurement,
    this.thumbnail,
    this.price,
    this.unitPrice,
    this.customerNote,
    this.weight,
    this.minPrice,
    this.prices,
    this.unit,
  });

  factory CartItem.fromJson(String jsonStr) => CartItem.fromMap(json.decode(jsonStr));

  String toJson() => json.encode(toMap());

  factory CartItem.fromMap(Map<String, dynamic> map) {
    return CartItem(
      serviceId: map['serviceId'],
      centerId: map['centerId'],
      name: map['name'],
      thumbnail: map['thumbnail'],
      priceType: map['priceType'],
      price: map['price'],
      unitPrice: map['unitPrice'],
      measurement: map['measurement'],
      customerNote: map['customerNote'],
      weight: map['weight'],
      minPrice: map['minPrice'],
      prices: List<Prices>.from(map['prices']?.map((x) => Prices.fromJson(x))),
      unit: map['unit'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'serviceId': serviceId,
      'centerId': centerId,
      'name': name,
      'thumbnail': thumbnail,
      'priceType': priceType,
      'price': price,
      'unitPrice': unitPrice,
      'measurement': measurement,
      'customerNote': customerNote,
      'weight': weight,
      'minPrice': minPrice,
      'prices': List<dynamic>.from(prices?.map((x) => x.toJson()) ?? []),
      'unit': unit,
    };
  }
}

// // ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'package:flutter/material.dart';
// import 'package:washouse_customer/resource/models/service.dart';
// import 'package:washouse_customer/screens/center/component/details/category_menu.dart';

// class CartItem {
//   ServiceDemo service;
//   num measurement;

//   CartItem({
//     required this.service,
//     required this.measurement,
//   });

//   Map<String, dynamic> toJson() => {
//         'service': service,
//         'measurement': measurement,
//       };

//   CartItem.fromJson(Map<String, dynamic> json)
//       : service = json['service'],
//         measurement = json['measurement'];
// }

// List<CartItem> demoCarts = [
//   CartItem(service: demoServices[0], measurement: 1),
//   CartItem(service: demoServices[1], measurement: 3),
//   CartItem(service: demoServices[2], measurement: 2),
// ];

// List<ServiceDemo> demoServices = [
//   ServiceDemo(
//     id: 1,
//     unit: 'Kg',
//     description: '1',
//     name: 'Giặt sấy rèm cửa',
//     image: 'assets/images/category/curtains_outlined.png',
//     price: 45000,
//   ),
//   ServiceDemo(
//     id: 2,
//     unit: 'Cái',
//     description: '2',
//     name: 'Giặt hấp caravat',
//     image: 'assets/images/category/tie.png',
//     price: 40000,
//   ),
//   ServiceDemo(
//     id: 3,
//     unit: 'Đôi',
//     description: '3',
//     name: 'Giặt giày',
//     image: 'assets/images/category/neck-pillow.png',
//     price: 60000,
//   ),
// ];

