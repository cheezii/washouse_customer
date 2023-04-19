import 'dart:convert';
import 'package:http/http.dart';
import 'package:washouse_customer/resource/controller/base_controller.dart';
import '../../components/constants/text_constants.dart';

BaseController baseController = BaseController();

class FeedbackController {
  Future<String> createFeedbackOrder(String orderId, int centerId, String content, int rating) async {
    String message = "";
    try {
      String url = '$baseUrl/feedbacks/orders';
      dynamic requestBody = {"orderId": orderId, "centerId": centerId, "content": content, "rating": rating};
      Response response = await baseController.makeAuthenticatedPostRequest(url, {}, requestBody);
      print(response.body);
      if (response.statusCode == 200) {
        // Handle successful response
        var data = jsonDecode(response.body)["message"];
        message = data;
        // Do something with the user data...
      } else {
        // Handle error response
        throw Exception('Error fetching createFeedbackOrder: ${response.statusCode}');
      }
    } catch (e) {
      print('error: createFeedbackOrder-$e');
    }
    return message;
  }
}
