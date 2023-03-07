// ignore_for_file: public_member_api_docs, sort_constructors_first
class Category {
  String thumbnail;
  String name;
  int noOfService;

  Category({
    required this.thumbnail,
    required this.name,
    required this.noOfService,
  });
}

List<Category> categoryList = [
  Category(
    thumbnail: 'assets/images/category/vest.png',
    name: 'Giặt hấp',
    noOfService: 23,
  ),
  Category(
    thumbnail: 'assets/images/category/handbag.png',
    name: 'Chăm sóc túi xách',
    noOfService: 23,
  ),
  Category(
    thumbnail: 'assets/images/category/belt.png',
    name: 'Chăm sóc dây lưng',
    noOfService: 23,
  ),
  Category(
    thumbnail: 'assets/images/category/sneaker.png',
    name: 'Chăm sóc giày',
    noOfService: 23,
  ),
];
