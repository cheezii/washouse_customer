import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:washouse_customer/resource/models/current_user.dart';
import 'package:washouse_customer/resource/models/map_user.dart';
import 'package:washouse_customer/resource/models/response_models/LoginResponseModel.dart';
import 'package:washouse_customer/resource/models/token.dart';
import 'package:washouse_customer/resource/controller/base_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../components/constants/text_constants.dart';

BaseController baseController = BaseController();

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
    CurrentUser currentUser = new CurrentUser();
    try {
      String url = '$baseUrl/accounts/me';
      http.Response response =
          await baseController.makeAuthenticatedRequest(url, {});
      print(response.statusCode);
      if (response.statusCode == 200) {
        // Handle successful response
        currentUser = CurrentUser?.fromJson(jsonDecode(response.body)["data"]);
        print(currentUser.name);
        // Do something with the user data...
      } else {
        // Handle error response
        throw Exception('Error fetching user data: ${response.statusCode}');
      }
    } catch (e) {
      print('error: getCurrentUser-$e');
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
      print("a");
      var statusCode = jsonDecode(response.body)["statusCode"];
      var message = jsonDecode(response.body)["message"];
      if (statusCode == 10) {
        return new LoginResponseModel(
            statusCode: 10, message: message, data: null);
      }
      if (statusCode == 17) {
        return new LoginResponseModel(
            statusCode: 17,
            message: "Admin không thể đăng nhập vào mobile",
            data: null);
      }

      Token? token = jsonDecode(response.body)["data"] != null
          ? Token?.fromJson(jsonDecode(response.body)["data"])
          : null;
      if (token != null) {
        responseModel = new LoginResponseModel(
            statusCode: statusCode, message: message, data: token);
      }
      if (statusCode == 0 && token != null) {
        var accessToken = token.accessToken;
        print(accessToken);
        var refreshToken = token.refreshToken;
        if (accessToken != null && refreshToken != null) {
          await baseController.saveAccessToken(accessToken);
          await baseController.saveRefreshToken(refreshToken);
        }
      }
    } catch (e) {
      print('error: $e');
    }
    return responseModel;
  }
}