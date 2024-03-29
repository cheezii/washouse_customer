class FeedbackModel {
  int? id;
  String? content;
  int? rating;
  String? orderId;
  int? centerId;
  String? centerName;
  int? serviceId;
  String? serviceName;
  String? createdBy;
  String? createdDate;
  String? replyMessage;
  String? replyBy;
  String? replyDate;

  FeedbackModel(
      {this.id,
      this.content,
      this.rating,
      this.orderId,
      this.centerId,
      this.centerName,
      this.serviceId,
      this.serviceName,
      this.createdBy,
      this.createdDate,
      this.replyMessage,
      this.replyBy,
      this.replyDate});

  FeedbackModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    content = json['content'];
    rating = json['rating'];
    orderId = json['orderId'];
    centerId = json['centerId'];
    centerName = json['centerName'];
    serviceId = json['serviceId'];
    serviceName = json['serviceName'];
    createdBy = json['createdBy'];
    createdDate = json['createdDate'];
    replyMessage = json['replyMessage'];
    replyBy = json['replyBy'];
    replyDate = json['replyDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['content'] = this.content;
    data['rating'] = this.rating;
    data['orderId'] = this.orderId;
    data['centerId'] = this.centerId;
    data['centerName'] = this.centerName;
    data['serviceId'] = this.serviceId;
    data['serviceName'] = this.serviceName;
    data['createdBy'] = this.createdBy;
    data['createdDate'] = this.createdDate;
    data['replyMessage'] = this.replyMessage;
    data['replyBy'] = this.replyBy;
    data['replyDate'] = this.replyDate;
    return data;
  }
}

// // ignore_for_file: public_member_api_docs, sort_constructors_first
// class FeedbackModel {
//   final String avatar;
//   final String name;
//   final String date;
//   final String content;
//   final double rating;
//   FeedbackModel({
//     required this.avatar,
//     required this.name,
//     required this.date,
//     required this.content,
//     required this.rating,
//   });
// }

// List<FeedbackModel> demoFeedbackList = [
//   FeedbackModel(
//     avatar: 'assets/images/profile/3.jpg',
//     name: 'curentUser',
//     date: '20/12/2023 12:34:56',
//     content: 'abcdefghik',
//     rating: 4,
//   ),
//   FeedbackModel(
//     avatar: 'assets/images/profile/3.jpg',
//     name: 'curentUser',
//     date: '20/12/2023 12:34:56',
//     content:
//         'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
//     rating: 4,
//   ),
// ];
