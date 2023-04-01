// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/foundation.dart';

import 'package:washouse_customer/resource/models/service.dart';

class ServiceDemo {
  final String name;
  final int id;
  final String image;
  final num price;
  final String description;
  ServiceDemo({
    required this.name,
    required this.image,
    required this.price,
    required this.description,
    required this.id,
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
        id: 1,
        name: 'abcde',
        image: 'assets/images/placeholder.png',
        price: 12000,
        description:
            "A text button is a label child displayed on a (zero elevation) Material widget. The label's Text and Icon widgets are displayed in the style's ButtonStyle.",
      ),
      ServiceDemo(
        id: 2,
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
        id: 3,
        name: 'abcde',
        image: 'assets/images/placeholder.png',
        price: 12000,
        description:
            "A text button is a label child displayed on a (zero elevation) Material widget. The label's Text and Icon widgets are displayed in the style's ButtonStyle.",
      ),
      ServiceDemo(
        id: 4,
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
        id: 5,
        name: 'abcde',
        image: 'assets/images/placeholder.png',
        price: 12000,
        description:
            "A text button is a label child displayed on a (zero elevation) Material widget. The label's Text and Icon widgets are displayed in the style's ButtonStyle.",
      ),
      ServiceDemo(
        id: 6,
        name: 'abcde',
        image: 'assets/images/placeholder.png',
        price: 12000,
        description:
            "A text button is a label child displayed on a (zero elevation) Material widget. The label's Text and Icon widgets are displayed in the style's ButtonStyle.",
      ),
    ],
  )
];
