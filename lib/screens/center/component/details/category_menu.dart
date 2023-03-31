// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/foundation.dart';

import 'package:washouse_customer/resource/models/service.dart';

class ServiceDemo {
  final String name;
  final String image;
  final num price;
  final String description;
  ServiceDemo({
    required this.name,
    required this.image,
    required this.price,
    required this.description,
  });
}

class CategoryMenu {
  final String categoryName;
  final List<ServiceDemo> item;
  CategoryMenu({
    required this.categoryName,
    required this.item,
  });
}

List<CategoryMenu> demoCateList = [
  CategoryMenu(
    categoryName: 'Dịch vụ giặt ủi',
    item: [
      ServiceDemo(
        name: 'abcde',
        image: 'assets/images/placeholder.png',
        price: 12000,
        description:
            "A text button is a label child displayed on a (zero elevation) Material widget. The label's Text and Icon widgets are displayed in the style's ButtonStyle.",
      ),
      ServiceDemo(
        name: 'abcde',
        image: 'assets/images/placeholder.png',
        price: 12000,
        description:
            "A text button is a label child displayed on a (zero elevation) Material widget. The label's Text and Icon widgets are displayed in the style's ButtonStyle.",
      ),
    ],
  ),
  CategoryMenu(
    categoryName: 'Dịch vụ giặt sấy',
    item: [
      ServiceDemo(
        name: 'abcde',
        image: 'assets/images/placeholder.png',
        price: 12000,
        description:
            "A text button is a label child displayed on a (zero elevation) Material widget. The label's Text and Icon widgets are displayed in the style's ButtonStyle.",
      ),
      ServiceDemo(
        name: 'abcde',
        image: 'assets/images/placeholder.png',
        price: 12000,
        description:
            "A text button is a label child displayed on a (zero elevation) Material widget. The label's Text and Icon widgets are displayed in the style's ButtonStyle.",
      ),
    ],
  ),
  CategoryMenu(
    categoryName: 'Dịch vụ giặt áo',
    item: [
      ServiceDemo(
        name: 'abcde',
        image: 'assets/images/placeholder.png',
        price: 12000,
        description:
            "A text button is a label child displayed on a (zero elevation) Material widget. The label's Text and Icon widgets are displayed in the style's ButtonStyle.",
      ),
      ServiceDemo(
        name: 'abcde',
        image: 'assets/images/placeholder.png',
        price: 12000,
        description:
            "A text button is a label child displayed on a (zero elevation) Material widget. The label's Text and Icon widgets are displayed in the style's ButtonStyle.",
      ),
    ],
  )
];
