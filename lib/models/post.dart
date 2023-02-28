// ignore_for_file: public_member_api_docs, sort_constructors_first
class Post {
  String thumbnail;
  String title;

  Post({
    required this.thumbnail,
    required this.title,
  });
}

List<Post> postList = [
  Post(
    thumbnail: 'assets/images/post/service.png',
    title: 'Cách để giữ cho tủ quần áo của bạn luôn thơm tho',
  ),
  Post(
    thumbnail: 'assets/images/placeholder.png',
    title: 'Làm sao để giặt giày sạch sẽ',
  ),
];
