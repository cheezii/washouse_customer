import 'dart:convert';
import 'package:http/http.dart';
import 'package:washouse_customer/resource/controller/base_controller.dart';
import '../../components/constants/text_constants.dart';
import '../models/feedback.dart';

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

  Future<String> createFeedbackService(int serviceId, int centerId, String content, int rating) async {
    String message = "";
    try {
      String url = '$baseUrl/feedbacks/services';
      dynamic requestBody = {"serviceId": serviceId, "centerId": centerId, "content": content, "rating": rating};
      Response response = await baseController.makeAuthenticatedPostRequest(url, {}, requestBody);
      print(response.body);
      if (response.statusCode == 200) {
        // Handle successful response
        var data = jsonDecode(response.body)["message"];
        message = data;
        // Do something with the user data...
      } else {
        // Handle error response
        throw Exception('Error fetching createFeedbackService: ${response.statusCode}');
      }
    } catch (e) {
      print('error: createFeedbackService-$e');
    }
    return message;
  }

  Future<List<FeedbackModel>?> getCenterFeedback(int centerId) async {
    List<FeedbackModel>? feedbacks = [];
    try {
      String url = '$baseUrl/feedbacks/centers/$centerId';
      Map<String, dynamic> queryParams = {'Page': '1', 'PageSize': '30'};
      final Uri uri = Uri.parse(url).replace(queryParameters: queryParams);
      final response = await get(uri, headers: {});
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body)['data']['items'] as List;
        feedbacks = data.map((e) => FeedbackModel.fromJson(e)).toList();
        return feedbacks; // Return the feedbacks list to the caller
      } else {
        // Error response
        throw Exception('Error fetching feedbacks data: ${response.statusCode}');
      }
    } catch (e) {
      print('error: getCenterFeedback-$e');
      throw e;
    }
  }
}
