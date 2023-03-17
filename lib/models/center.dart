// ignore_for_file: public_member_api_docs, sort_constructors_first
class Center {
  int id;
  String centerName;
  String location;
  String phone;
  List<String> image;
  int status;
  double rating;
  double distance;
  String description;
  Center({
    required this.id,
    required this.centerName,
    required this.location,
    required this.phone,
    required this.image,
    required this.status,
    required this.rating,
    required this.distance,
    required this.description,
  });
}

List<Center> centerList = [
  Center(
    id: 1,
    centerName: 'The Washouse',
    location: '477 Man Thiện',
    phone: '0912345678',
    image: [
      'assets/images/post/laundry-room.jpg',
    ],
    status: 1,
    distance: 0.5,
    rating: 4.6,
    description: 'Tiệm giặt ủi  thông minh',
  ),
  Center(
    id: 1,
    centerName: 'The Cleanhouse',
    location: '123 Man Thiện',
    phone: '0912345678',
    image: [
      'assets/images/post/laundry-room.jpg',
    ],
    rating: 3,
    status: 1,
    distance: 0.6,
    description: 'Tiệm giặt ủi  thông minh',
  ),
  Center(
    id: 1,
    centerName: 'Tiệm giặt Mai Thúy',
    location: '75 Hàng Tre',
    phone: '0912345678',
    image: [
      'assets/images/post/laundry-room.jpg',
    ],
    rating: 3,
    distance: 1,
    status: 1,
    description: 'Tiệm giặt ủi  thông minh',
  ),
];
