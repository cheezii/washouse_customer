import 'package:washouse_customer/resource/models/token.dart';

class CenterResponseModel {
  int? statusCode;
  String? message;

  CenterResponseModel({this.statusCode, this.message});

  CenterResponseModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    message = json['message'];
  }
}
