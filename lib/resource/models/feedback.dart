// ignore_for_file: public_member_api_docs, sort_constructors_first
class FeedbackModel {
  final String avatar;
  final String name;
  final String date;
  final String content;
  final double rating;
  FeedbackModel({
    required this.avatar,
    required this.name,
    required this.date,
    required this.content,
    required this.rating,
  });
}

List<FeedbackModel> demoFeedbackList = [
  FeedbackModel(
    avatar: 'assets/images/profile/3.jpg',
    name: 'curentUser',
    date: '20/12/2023 12:34:56',
    content: 'abcdefghik',
    rating: 4,
  ),
  FeedbackModel(
    avatar: 'assets/images/profile/3.jpg',
    name: 'curentUser',
    date: '20/12/2023 12:34:56',
    content:
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
    rating: 4,
  ),
];
