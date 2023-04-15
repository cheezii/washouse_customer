import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:washouse_customer/resource/controller/base_controller.dart';
import '../../components/constants/text_constants.dart';

BaseController baseController = BaseController();

class TrackingController {
  Future<String> cancelledOrder(String orderId) async {
    try {
      String url = '$baseUrl/tracking/orders/$orderId/cancelled';
      Map<String, dynamic> queryParams = {};
      Map<String, dynamic> requestBody = {};
      //print(queryParams.toString());
      Response response = await baseController.makeAuthenticatedPutRequest(url, queryParams, requestBody);
      var data = jsonDecode(response.body)["message"];
      if (response.statusCode == 200) {
        // Handle successful response
        return data;
        // Do something with the user data...
      } else {
        // Handle error response
        throw Exception('Error fetching cancelledOrder: ${response.statusCode}');
      }
    } catch (e) {
      print('error: paymentOrder-$e');
      return 'error_fetch';
    }
  }
}
