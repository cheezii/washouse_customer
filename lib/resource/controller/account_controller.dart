import 'dart:convert';

import 'package:http/http.dart';
import 'package:washouse_customer/resource/models/map_user.dart';

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

  Future login(String phone, String password) async {
    String? message;
    try {
      Map data = {"phone": phone, "password": password};
      print(data);

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

      if (response.statusCode == 200) {
        message = "success";
        var data = jsonDecode(response.body)["data"];
        print(response.body);
      } else {
        print(response.body);
      }
    } catch (e) {
      print('error: $e');
    }
    return message;
  }
}
