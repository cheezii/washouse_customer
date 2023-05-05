import 'dart:convert';

import 'package:http/http.dart';

import '../../components/constants/text_constants.dart';

class VerifyController {
  Future<bool> getOTPByEmail(String email) async {
    Response response = await post(Uri.parse('$baseUrl/verifys/send/mail?email=$email'));
    try {
      var data = jsonDecode(response.body);
      if (data['statusCode'] == 200) {
        return true;
      } else {
        print(data['message']);
      }
    } catch (e) {
      print('error: $e');
    }
    return false;
  }

  Future<bool> checkOTPByEmail(String otp) async {
    Response response = await post(Uri.parse('$baseUrl/verifys/mail/$otp'));
    try {
      var data = jsonDecode(response.body);
      if ('Verify success'.compareTo(data['message']) == 0) {
        return true;
      } else {
        print(data['message']);
      }
    } catch (e) {
      print('error: $e');
    }
    return false;
  }

  Future<bool> checkOTPByPhone(String phone, String otp) async {
    try {
      Map data = {"otp": otp, "phonenumber": phone};
      String body = json.encode(data);
      var url = '$baseUrl/verifys/sms/check';
      var response = await post(
        Uri.parse(url),
        body: body,
        headers: {
          'accept': '*/*',
          'Content-Type': 'application/json',
        },
      );
      var jsonResponse = jsonDecode(response.body);
      print(jsonResponse);
      if (response.statusCode == 200) {
        //message = 'success';
        print("success");
        return true;
      } else {
        throw Exception('Lỗi khi load json');
      }
    } catch (e) {
      print('error: $e');
      return false;
    }
  }
}
