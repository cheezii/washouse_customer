// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class Service {
  int id;
  String title;
  List<String> image;
  List<Color> color;
  double rating, price;

  Service({
    required this.id,
    required this.title,
    required this.image,
    this.rating = 0.0,
    required this.color,
    required this.price,
  });
}

List<Service> demoServices = [
  Service(
    id: 1,
    title: 'Giặt sấy rèm cửa',
    image: [
      'assets/images/category/curtains_outlined.png',
    ],
    color: [
      const Color(0xfff6625e),
      const Color(0xff836db8),
      const Color(0xffdecb9c),
      Colors.white
    ],
    price: 45000,
  ),
  Service(
    id: 2,
    title: 'Giặt hấp caravat',
    image: [
      'assets/images/category/tie.png',
    ],
    color: [
      const Color(0xfff6625e),
      const Color(0xff836db8),
      const Color(0xffdecb9c),
      Colors.white
    ],
    price: 40000,
  ),
  Service(
    id: 3,
    title: 'Giặt hấp gối cổ',
    image: [
      'assets/images/category/neck-pillow.png',
    ],
    color: [
      const Color(0xfff6625e),
      const Color(0xff836db8),
      const Color(0xffdecb9c),
      Colors.white
    ],
    price: 60000,
  ),
];
