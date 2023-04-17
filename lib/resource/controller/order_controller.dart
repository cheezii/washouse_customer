import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:washouse_customer/resource/provider/cart_provider.dart';
import 'package:washouse_customer/resource/models/current_user.dart';
import 'package:washouse_customer/resource/models/customer.dart';
import 'package:washouse_customer/resource/models/map_user.dart';
import 'package:washouse_customer/resource/models/order_body.dart';
import 'package:washouse_customer/resource/models/response_models/LoginResponseModel.dart';
import 'package:washouse_customer/resource/models/token.dart';
import 'package:washouse_customer/resource/controller/base_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:washouse_customer/resource/models/wallet.dart';

import '../../components/constants/text_constants.dart';
import '../models/cart_item.dart';
import '../models/response_models/order_detail_information.dart';
import '../models/response_models/order_item_list.dart';

BaseController baseController = BaseController();

class OrderController {
  final BuildContext context;

  OrderController(this.context);
  Future<String?> createOrder() async {
    String url = '$baseUrl/orders';
    Map<String, dynamic> queryParams = {};
    var orderBody = new OrderBody();
    var order = new Order();
    var orderDetails = [];
    var deliveries = [];

    orderBody.centerId = await baseController.getInttoSharedPreference("centerId");
    order.customerName = await baseController.getStringtoSharedPreference("customerName");
    order.customerAddressString = await baseController.getStringtoSharedPreference("customerAddressString");
    order.customerWardId = await baseController.getInttoSharedPreference("customerWardId");
    order.customerEmail = await baseController.getStringtoSharedPreference("CURRENT_USER_EMAIL");
    order.customerMobile = await baseController.getStringtoSharedPreference("customerPhone");
    order.customerMessage = await baseController.getStringtoSharedPreference("customerMessage");
    order.deliveryType = await baseController.getInttoSharedPreference("deliveryType");
    String? preferredDropoffTime_Date = await baseController.getStringtoSharedPreference("preferredDropoffTime_Date");
    String? preferredDropoffTime_Time = await baseController.getStringtoSharedPreference("preferredDropoffTime_Time");
    if (preferredDropoffTime_Date != null &&
        preferredDropoffTime_Time != null &&
        preferredDropoffTime_Date != "" &&
        preferredDropoffTime_Time != "") {
      print(preferredDropoffTime_Date + " " + preferredDropoffTime_Time);
      order.preferredDropoffTime = preferredDropoffTime_Date + " " + preferredDropoffTime_Time;
    }

    List<CartItem> listCartItems = Provider.of<CartProvider>(context, listen: false).cartItems;
    print(listCartItems.length);
    for (var element in listCartItems) {
      var orderDetail = new Order_Details();
      orderDetail.serviceId = element.serviceId;
      orderDetail.measurement = element.measurement;
      orderDetail.price = element.price;
      orderDetail.customerNote = element.customerNote;
      orderDetail.staffNote = null;
      orderDetails.add(orderDetail);
    }

    order.deliveryPrice = await baseController.getDoubletoSharedPreference("deliveryPrice");
    if (order.deliveryType == null || (order.deliveryType != null && order.deliveryType == 0)) {
      order.deliveryType = 0;
    } else if (order.deliveryType == 1 || order.deliveryType == 3) {
      var delivery = new Deliveries();
      delivery.addressString = await baseController.getStringtoSharedPreference("addressString_Dropoff");
      delivery.wardId = await baseController.getInttoSharedPreference("wardId_Dropoff");
      delivery.deliveryType = false;
      deliveries.add(delivery);
    } else if (order.deliveryType == 2 || order.deliveryType == 3) {
      var delivery = new Deliveries();
      delivery.addressString = await baseController.getStringtoSharedPreference("addressString_Delivery");
      delivery.wardId = await baseController.getInttoSharedPreference("wardId_Delivery");
      delivery.deliveryType = true;
      deliveries.add(delivery);
    }
    String promotionCode = await baseController.getStringtoSharedPreference("promoCode");
    if (promotionCode != "") {
      orderBody.promoCode = promotionCode;
    }
    orderBody.paymentMethod = await baseController.getInttoSharedPreference("paymentMethod");
    if (orderBody.paymentMethod == null) orderBody.paymentMethod = 0;
    orderBody.deliveries = deliveries.cast<Deliveries>();
    orderBody.orderDetails = orderDetails.cast<Order_Details>();
    orderBody.order = order;
    if (orderBody.order!.preferredDropoffTime == null) {
      orderBody.order!.preferredDropoffTime = DateFormat('dd-MM-yyyy HH:mm:ss').format(DateTime.now());
    }
    OrderBody requestBody = orderBody;
    print(requestBody.toJson());
    final headers = {'Content-Type': 'application/json'};
    http.Response response = await http.post(Uri.parse('$baseUrl/orders'), headers: headers, body: json.encode(requestBody.toJson()));
    dynamic responseData = json.decode(response.body);
    print(responseData);
    // Make the authenticated POST requests
    // http.Response response = await baseController.makeAuthenticatedPostRequest(
    //     url, queryParams, requestBody);

    // Check the response status code
    if (response.statusCode == 200) {
      // Request was successful, parse the response body
      dynamic responseData = json.decode(response.body);
      Provider.of<CartProvider>(context, listen: false).removeCart();
      baseController.printAllSharedPreferences();
      // Do something with the response data
      print(responseData);

      return responseData["data"]["orderId"];
    } else {
      // Request failed, handle the error
      dynamic responseData = json.decode(response.body);
      print(responseData);
    }
  }

  Future<double> calculateDeliveryPrice(
      String? DropoffAddress, int? DropoffWardId, String? DeliverAddress, int? DeliverWardId, bool checkDropoff, bool checkDeliver) async {
    String url = '$baseUrl/orders/delivery-price';
    List<CartItem> listCartItems = Provider.of<CartProvider>(context, listen: false).cartItems;
    double totalWeight = 0;
    for (var element in listCartItems) {
      if (element.weight != null) {
        totalWeight = totalWeight + element.measurement * element.weight!;
      }
    }
    late Map<String, dynamic> queryParams;
    if (checkDropoff && checkDeliver) {
      queryParams = {
        'CenterId': await baseController.getInttoSharedPreference("centerId"),
        'TotalWeight': totalWeight,
        'DropoffAddress': DropoffAddress,
        'DropoffWardId': DropoffWardId ?? 0,
        'DeliverAddress': DeliverAddress,
        'DeliverWardId': DeliverWardId ?? 0,
        'DeliveryType': 3
      };
    } else if (checkDropoff && !checkDeliver) {
      queryParams = {
        'CenterId': await baseController.getInttoSharedPreference("centerId"),
        'TotalWeight': totalWeight,
        'DropoffAddress': DropoffAddress,
        'DropoffWardId': DropoffWardId ?? 0,
        'DeliveryType': 1
      };
    } else if (!checkDropoff && checkDeliver) {
      queryParams = {
        'CenterId': await baseController.getInttoSharedPreference("centerId"),
        'TotalWeight': totalWeight,
        'DeliverAddress': DeliverAddress,
        'DeliverWardId': DeliverWardId ?? 0,
        'DeliveryType': 2
      };
    }

    print(queryParams.toString());
    final response =
        await http.get(Uri.parse(url + '?' + Uri(queryParameters: queryParams.map((key, value) => MapEntry(key, value.toString()))).query));
    dynamic responseData = json.decode(response.body);
    print(responseData["message"]);
    // Make the authenticated POST requests
    // http.Response response = await baseController.makeAuthenticatedPostRequest(
    //     url, queryParams, requestBody);

    // Check the response status code
    if (response.statusCode == 200) {
      // Request was successful, parse the response body
      dynamic responseData = json.decode(response.body);
      // Do something with the response data
      return responseData["data"]["deliveryPrice"];
    } else {
      // Request failed, handle the error
      print(responseData["message"]);

      return 0;
    }
  }

  Future<Order_Infomation> getOrderInformation(String orderId) async {
    var order_Infomation = new Order_Infomation();
    try {
      String url = '$baseUrl/orders/search';
      Map<String, dynamic> queryParams = {"OrderId": orderId, "Phone": await baseController.getStringtoSharedPreference("CURRENT_USER_PHONE")};
      //print(queryParams.toString());
      Response response = await baseController.makeAuthenticatedRequest(url, queryParams);
      if (response.statusCode == 200) {
        // Handle successful response
        order_Infomation = Order_Infomation?.fromJson(jsonDecode(response.body)["data"]);
        print(order_Infomation.orderTrackings != null);
        // Do something with the user data...
      } else {
        // Handle error response
        throw Exception('Error fetching user data: ${response.statusCode}');
      }
    } catch (e) {
      print('error: getOrderInformation-$e');
    }
    return order_Infomation;
  }

  Future<List<Order_Item>> getOrderList(
      int? Page, int? PageSize, String? SearchString, String? FromDate, String? ToDate, String? Status, String? OrderType) async {
    List<Order_Item> orderItems = [];
    try {
      String url = '$baseUrl/orders';
      Map<String, dynamic> queryParams = {
        "Page": Page.toString(),
        "PageSize": PageSize.toString(),
        "SearchString": SearchString,
        "FromDate": FromDate,
        "ToDate": ToDate,
        "Status": Status,
        "OrderType": OrderType,
      };
      //print(queryParams.toString());
      Response response = await baseController.makeAuthenticatedRequest(url, queryParams);
      print(response.body);
      if (response.statusCode == 200) {
        // Handle successful response
        var data = jsonDecode(response.body)["data"]['items'] as List;
        orderItems = data.map((e) => Order_Item.fromJson(e)).toList();
        // Do something with the user data...
      } else {
        // Handle error response
        throw Exception('Error fetching user data: ${response.statusCode}');
      }
    } catch (e) {
      print('error: getOrderList-$e');
    }
    return orderItems;
  }

  Future<String> paymentOrder(String orderId) async {
    var order_Infomation = new Order_Infomation();
    try {
      String url = '$baseUrl/orders/$orderId/payment';
      Map<String, dynamic> queryParams = {"OrderId": orderId};
      //print(queryParams.toString());
      Response response = await baseController.makeAuthenticatedRequest(url, queryParams);
      print(response.body);
      var data = jsonDecode(response.body)["message"];
      if (response.statusCode == 200) {
        // Handle successful response
        return data;
        // Do something with the user data...
      } else {
        // Handle error response
        throw Exception('Error fetching paymentOrder: ${response.statusCode}');
      }
    } catch (e) {
      print('error: paymentOrder-$e');

      return 'error_fetch';
    }
  }
}
