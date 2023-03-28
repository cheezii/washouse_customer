class MapUser {
  final int districtId;
  final String districtName;
  final int wardId;
  final String wardName;
  final String addressName;
  final String displayName;

  MapUser({
    required this.districtId,
    required this.districtName,
    required this.wardId,
    required this.wardName,
    required this.addressName,
    required this.displayName,
  });

  factory MapUser.fromJson(Map<String, dynamic> json) {
    return MapUser(
      districtId: json['districtId'] as int,
      districtName: json['districtName'] as String,
      wardId: json['wardId'] as int,
      wardName: json['wardName'] as String,
      addressName: json['addressName'] as String,
      displayName: json['displayName'] as String,
    );
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['districtId'] = this.districtId;
  //   data['districtName'] = this.districtName;
  //   data['wardId'] = this.wardId;
  //   data['wardName'] = this.wardName;
  //   data['addressName'] = this.addressName;
  //   data['displayName'] = this.displayName;
  //   return data;
  // }
}

// class MapUser {
//   int statusCode;
//   String message;
//   Data data;

//   MapUser(
//       {required this.statusCode, required this.message, required this.data});

//   factory MapUser.fromJson(Map<String, dynamic> json) {
//     return MapUser(
//       statusCode: json['statusCode'],
//       message: json['message'],
//       data: Data.fromJson(json['data']),
//     );
//   }

//   // MapUser.fromJson(Map<String, dynamic> json) {
//   //   statusCode = json['statusCode'];
//   //   message = json['message'];
//   //   data = json["data"].map<Data>((json) => Data.fromJson(json));
//   // }

//   // Map<String, dynamic> toJson() {
//   //   final Map<String, dynamic> data = <String, dynamic>{};
//   //   data['statusCode'] = this.statusCode;
//   //   data['message'] = this.message;
//   //   if (this.data != null) {
//   //     data['data'] = this.data.toJson();
//   //   }
//   //   return data;
//   // }
// }

// class Data {
//   int districtId;
//   String districtName;
//   int wardId;
//   String wardName;
//   String addressName;
//   String displayName;

//   Data(
//       {required this.districtId,
//       required this.districtName,
//       required this.wardId,
//       required this.wardName,
//       required this.addressName,
//       required this.displayName});

//   factory Data.fromJson(Map<String, dynamic> json) {
//     return Data(
//       districtId: json['districtId'],
//       districtName: json['districtName'],
//       wardId: json['wardId'],
//       wardName: json['wardName'],
//       addressName: json['addressName'],
//       displayName: json['displayName'],
//     );
//   }

//   // Map<String, dynamic> toJson() {
//   //   final Map<String, dynamic> data = new Map<String, dynamic>();
//   //   data['districtId'] = this.districtId;
//   //   data['districtName'] = this.districtName;
//   //   data['wardId'] = this.wardId;
//   //   data['wardName'] = this.wardName;
//   //   data['addressName'] = this.addressName;
//   //   data['displayName'] = this.displayName;
//   //   return data;
//   // }
// }
