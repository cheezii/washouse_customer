// ignore_for_file: public_member_api_docs, sort_constructors_first
class Post {
  int id;
  String thumbnail;
  String title;

  Post({
    required this.id,
    required this.thumbnail,
    required this.title,
  });
}

List<Post> postList = [
  Post(
    id: 1,
    thumbnail: 'assets/images/post/laundry-room.jpg',
    title: 'Cách giữ quần áo luôn thơm tho',
  ),
  Post(
    id: 2,
    thumbnail: 'assets/images/placeholder.png',
    title: 'Làm sao để giặt giày sạch sẽ',
  ),
  Post(
    id: 3,
    thumbnail: 'assets/images/post/service.png',
    title: 'Bao lâu bạn giặt đồ một lần?',
  ),
];
