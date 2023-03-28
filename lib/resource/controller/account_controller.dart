import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:washouse_customer/resource/models/map_user.dart';

import '../../components/constants/text_constants.dart';

class AccountController {
  Future register(String phone, pass, conpass) async {
    String message;
    Map data = {
      "phone": phone,
      "email": "",
      "password": pass,
      "confirmPass": conpass
    };
    print(data);

    String body = json.encode(data);
    var url = '$baseUrl/accounts/registerAsCustomer';
    var response = await http.post(
      Uri.parse(url),
      body: body,
      headers: {
        "Content-Type": "application/json",
        "accept": "application/json",
        "Access-Control-Allow-Origin": "*"
      },
    );
    print(response.body);
    print(response.statusCode);
    var jsonResponse = jsonDecode(response.body);
    if (response.statusCode == 200) {
      //Or put here your next screen using Navigator.push() method
      print('success');
    } else {
      return message = jsonResponse(data['message']);
    }
  }
}
