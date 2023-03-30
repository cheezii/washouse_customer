import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:washouse_customer/resource/models/current_user.dart';
import 'package:washouse_customer/resource/models/map_user.dart';
import 'package:washouse_customer/resource/models/response_models/LoginResponseModel.dart';
import 'package:washouse_customer/resource/models/token.dart';

import '../../components/constants/text_constants.dart';

class AccountController {
  Future register(String phone, pass, conpass) async {
    //String? message;
    try {
      Map data = {
        "phone": phone,
        "email": "",
        "password": pass,
        "confirmPass": conpass
      };

      String body = json.encode(data);
      var url = '$baseUrl/accounts/customers';
      var response = await post(
        Uri.parse(url),
        body: body,
        headers: {
          "Content-Type": "application/json",
          "accept": "application/json",
          "Access-Control-Allow-Origin": "*"
        },
      );
      var jsonResponse = jsonDecode(response.body);
      print(jsonResponse);
      if (response.statusCode == 200) {
        //message = 'success';
        print("success");
      } else {
        throw Exception('Lỗi khi load json');
      }
    } catch (e) {
      print('error: $e');
    }
    //return message;
  }

  Future<CurrentUser> getCurrentUser() async {
    Response response_currentUser =
        await get(Uri.parse('$baseUrl/accounts/me'));
    CurrentUser currentUser = new CurrentUser();
    try {
      if (response_currentUser.statusCode == 200) {
        currentUser = jsonDecode(response_currentUser.body)['data'];
      } else {
        throw Exception("Lỗi khi load Json");
      }
    } catch (e) {
      print('error: $e');
    }
    return currentUser;
  }

  Future login(String phone, String password) async {
    //String? message;
    LoginResponseModel? responseModel;
    try {
      Map data = {"phone": phone, "password": password};
      String body = jsonEncode(data);
      Response response = await post(
        Uri.parse('$baseUrl/accounts/login'),
        body: body,
        headers: {
          "content-type": "application/json",
          "accept": "application/json",
          "access-control-allow-origin": "*",
        },
      );

      var statusCode = jsonDecode(response.body)["statusCode"];
      var message = jsonDecode(response.body)["message"];
      if (statusCode == 10) {
        return new LoginResponseModel(
            statusCode: 10, message: message, data: null);
      }
      Token? token = jsonDecode(response.body)["data"] != null
          ? Token?.fromJson(jsonDecode(response.body)["data"])
          : null;
      if (token != null) {
        responseModel = new LoginResponseModel(
            statusCode: statusCode, message: message, data: token);
      }
      if (statusCode == 17) {
        return new LoginResponseModel(
            statusCode: 17,
            message: "Admin không thể đăng nhập vào mobile",
            data: null);
      }
      if (statusCode == 0) {
        final accessToken = token?.accessToken;
      }
    } catch (e) {
      print('error: $e');
    }
    return responseModel;
  }
}
