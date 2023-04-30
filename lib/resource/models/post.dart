// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:washouse_customer/resource/controller/post_controller.dart';

class Post {
  int? id;
  String? title;
  String? content;
  String? description;
  String? thumbnail;
  String? type;
  String? status;
  String? createdDate;
  String? updatedDate;

  Post({this.id, this.title, this.content, this.description, this.thumbnail, this.type, this.status, this.createdDate, this.updatedDate});

  Post.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    content = json['content'];
    thumbnail = json['thumbnail'];
    type = json['type'];
    status = json['status'];
    createdDate = json['createdDate'];
    updatedDate = json['updatedDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['content'] = this.content;
    data['thumbnail'] = this.thumbnail;
    data['type'] = this.type;
    data['status'] = this.status;
    data['createdDate'] = this.createdDate;
    data['updatedDate'] = this.updatedDate;
    return data;
  }
}

// List<Post> postList = [
//   Post(
//     id: 1,
//     thumbnail: 'assets/images/post/laundry-room.jpg',
//     title: 'Cách giữ quần áo luôn thơm tho',
//     content:
//         'Thật khó chịu, bực bội biết nhường nào khi bắt đầu ngày mới với bộ quần áo bị ám mùi ẩm mốc, mùi hôi khó chịu. Để có bộ quần áo sạch thơm suốt cả ngày cho các thành viên trong gia đình bắt đầu ngày mới với sự tự tin.',
//   ),
//   Post(
//     id: 2,
//     thumbnail: 'assets/images/placeholder.png',
//     title: 'Làm sao để giặt giày sạch sẽ',
//     content:
//         'Giày thể thao bị dính bẩn, có mùi hôi khó chịu là vấn đề thường gặp với những ai thường xuyên sử dụng món phụ kiện này. Trong bài viết này, AVASport sẽ mách bạn một số cách vệ sinh giày thể thao đơn giản và hiệu quả.',
//   ),
//   Post(
//     id: 3,
//     thumbnail: 'assets/images/post/service.png',
//     title: 'Bao lâu bạn giặt đồ một lần?',
//     content:
//         'Để có một sức khỏe tốt thì việc giữ vệ sinh những vật dụng xung quanh là điều cần thiết. Thế nên, hãy tìm hiểu khoảng thời gian nên giặt giũ, vệ sinh đồ nhé!',
//   ),
// ];
