import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart';

import '../../components/constants/text_constants.dart';
import '../models/response_models/order_item_list.dart';
import 'package:washouse_customer/resource/controller/base_controller.dart';

class OrderListProvider extends ChangeNotifier {
  BaseController baseController = BaseController();
  List<Order_Item> _orderList = [];

  List<Order_Item> get orderList => _orderList;

  OrderListProvider() {
    loadOrderList();
  }

  Future<void> loadOrderList() async {
    try {
      String url = '$baseUrl/orders';
      Map<String, dynamic> queryParams = {};
      //print(queryParams.toString());
      Response response = await baseController.makeAuthenticatedRequest(url, queryParams);
      if (response.statusCode == 200) {
        // Handle successful response
        var data = jsonDecode(response.body)["data"]['items'] as List;
        _orderList = data.map((e) => Order_Item.fromJson(e)).toList();
        notifyListeners();
        // Do something with the user data...
      } else {
        // Handle error response
        throw Exception('Error fetching user data: ${response.statusCode}');
      }
    } catch (e) {
      print('error: getOrderList-$e');
    }
  }
}
