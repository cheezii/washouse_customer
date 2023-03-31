// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:washouse_customer/resource/models/service.dart';

class ServiceCategory {
  int? id;
  String? categoryName;
  String? alias;
  String? description;
  String? image;
  bool? status;
  bool? homeFlag;
  List<Service>? services;
  String? createdDate;
  String? createdBy;
  String? updatedDate;
  String? updatedBy;

  ServiceCategory(
      {this.id,
      this.categoryName,
      this.alias,
      this.description,
      this.image,
      this.status,
      this.homeFlag,
      this.services,
      this.createdDate,
      this.createdBy,
      this.updatedDate,
      this.updatedBy});

  ServiceCategory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryName = json['categoryName'];
    alias = json['alias'];
    description = json['description'];
    image = json['image'];
    status = json['status'];
    homeFlag = json['homeFlag'];
    if (json['services'] != null) {
      services = <Service>[];
      json['services'].forEach((v) {
        services!.add(new Service.fromJson(v));
      });
    }
    createdDate = json['createdDate'];
    createdBy = json['createdBy'];
    updatedDate = json['updatedDate'];
    updatedBy = json['updatedBy'];
  }
}
// class Category {
//   String thumbnail;
//   String name;

//   Category({
//     required this.thumbnail,
//     required this.name,
//   });
// }

// List<Category> categoryList = [
//   Category(
//     thumbnail: 'assets/images/category/ao-dai.png',
//     name: 'Áo dài',
//   ),
//   Category(
//     thumbnail: 'assets/images/category/belt.png',
//     name: 'Dây lưng',
//   ),
//   Category(
//     thumbnail: 'assets/images/category/bolster.png',
//     name: 'Gối ôm',
//   ),
//   Category(
//     thumbnail: 'assets/images/category/coat.png',
//     name: 'Áo khoác dài',
//   ),
//   Category(
//     thumbnail: 'assets/images/category/curtains_outlined.png',
//     name: 'Rèm màn',
//   ),
//   Category(
//     thumbnail: 'assets/images/category/down-jacket.png',
//     name: 'Áo phao',
//   ),
//   Category(
//     thumbnail: 'assets/images/category/dress.png',
//     name: 'Váy',
//   ),
//   Category(
//     thumbnail: 'assets/images/category/dry-cleaning.png',
//     name: 'Giặt khô',
//   ),
//   Category(
//     thumbnail: 'assets/images/category/groom-suit.png',
//     name: 'Bộ vest',
//   ),
//   Category(
//     thumbnail: 'assets/images/category/handbag.png',
//     name: 'Túi xách',
//   ),
//   Category(
//     thumbnail: 'assets/images/category/jean.png',
//     name: 'Quần jeans',
//   ),
//   Category(
//     thumbnail: 'assets/images/category/leather-jacket.png',
//     name: 'Áo da',
//   ),
//   Category(
//     thumbnail: 'assets/images/category/mattress-outlined.png',
//     name: 'Nệm',
//   ),
//   Category(
//     thumbnail: 'assets/images/category/neck-pillow.png',
//     name: 'Gối cổ',
//   ),
//   Category(
//     thumbnail: 'assets/images/category/pants.png',
//     name: 'Quần dài',
//   ),
//   Category(
//     thumbnail: 'assets/images/category/pillow.png',
//     name: 'Gối ngủ',
//   ),
//   Category(
//     thumbnail: 'assets/images/category/shawn.png',
//     name: 'Khăn quàng',
//   ),
//   Category(
//     thumbnail: 'assets/images/category/short.png',
//     name: 'Quần soọc',
//   ),
//   Category(
//     thumbnail: 'assets/images/category/skirt.png',
//     name: 'Chân váy',
//   ),
//   Category(
//     thumbnail: 'assets/images/category/sneaker.png',
//     name: 'Giày',
//   ),
//   Category(
//     thumbnail: 'assets/images/category/teddy-bear.png',
//     name: 'Gấu bông',
//   ),
//   Category(
//     thumbnail: 'assets/images/category/tie.png',
//     name: 'Cà vạt',
//   ),
// ];
