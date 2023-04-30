import 'dart:convert';
import 'package:http/http.dart';
import 'package:washouse_customer/resource/controller/base_controller.dart';
import '../../components/constants/text_constants.dart';

BaseController baseController = BaseController();

class PaymentController {
  Future<String> lauchVnpayLink(int money) async {
    String vnPayLink = "";
    try {
      String url = '$baseUrl/payments';
      Map<String, dynamic> queryParams = {"moneytowallet": money.toString()};
      //print(queryParams.toString());
      Response response = await baseController.makeAuthenticatedRequest(url, queryParams);
      print(response.body);
      if (response.statusCode == 200) {
        // Handle successful response
        var data = jsonDecode(response.body)["data"];
        vnPayLink = data;
        // Do something with the user data...
      } else {
        // Handle error response
        throw Exception('Error fetching lauchVnpayLink: ${response.statusCode}');
      }
    } catch (e) {
      print('error: lauchVnpayLink-$e');
    }
    return vnPayLink;
  }
}
