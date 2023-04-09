import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:washouse_customer/resource/controller/cart_provider.dart';
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

    orderBody.centerId =
        await baseController.getInttoSharedPreference("centerId");
    order.customerName =
        await baseController.getStringtoSharedPreference("customerName");
    order.customerAddressString = await baseController
        .getStringtoSharedPreference("customerAddressString");
    order.customerWardId =
        await baseController.getInttoSharedPreference("customerWardId");
    order.customerEmail =
        await baseController.getStringtoSharedPreference("CURRENT_USER_EMAIL");
    order.customerMobile =
        await baseController.getStringtoSharedPreference("customerPhone");
    order.customerMessage =
        await baseController.getStringtoSharedPreference("customerMessage");
    order.deliveryType =
        await baseController.getInttoSharedPreference("deliveryType");
    String? preferredDropoffTime_Date = await baseController
        .getStringtoSharedPreference("preferredDropoffTime_Date");
    String? preferredDropoffTime_Time = await baseController
        .getStringtoSharedPreference("preferredDropoffTime_Time");
    if (preferredDropoffTime_Date != null &&
        preferredDropoffTime_Time != null &&
        preferredDropoffTime_Date != "" &&
        preferredDropoffTime_Time != "") {
      order.preferredDropoffTime =
          preferredDropoffTime_Date + " " + preferredDropoffTime_Time;
    }

    String? preferredDeliverTime_Date = await baseController
        .getStringtoSharedPreference("preferredDeliverTime_Date");
    String? preferredDeliverTime_Time = await baseController
        .getStringtoSharedPreference("preferredDeliverTime_Time");
    if (preferredDeliverTime_Date != null &&
        preferredDeliverTime_Time != null &&
        preferredDeliverTime_Date != "" &&
        preferredDeliverTime_Time != "") {
      order.preferredDeliverTime =
          preferredDeliverTime_Date + " " + preferredDeliverTime_Time;
    }

    List<CartItem> listCartItems =
        Provider.of<CartProvider>(context, listen: false).cartItems;
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

    order.deliveryPrice =
        await baseController.getDoubletoSharedPreference("deliveryPrice");

    if (order.deliveryType == 1 || order.deliveryType == 3) {
      var delivery = new Deliveries();
      delivery.addressString = await baseController
          .getStringtoSharedPreference("addressString_Dropoff");
      delivery.wardId =
          await baseController.getInttoSharedPreference("wardId_Dropoff");
      delivery.deliveryType = false;
      deliveries.add(delivery);
    }
    if (order.deliveryType == 2 || order.deliveryType == 3) {
      var delivery = new Deliveries();
      delivery.addressString = await baseController
          .getStringtoSharedPreference("addressString_Delivery");
      delivery.wardId =
          await baseController.getInttoSharedPreference("wardId_Delivery");
      delivery.deliveryType = true;
      deliveries.add(delivery);
    }
    String promotionCode =
        await baseController.getStringtoSharedPreference("promoCode");
    if (promotionCode != "") {
      orderBody.promoCode = promotionCode;
    }
    orderBody.paymentMethod =
        await baseController.getInttoSharedPreference("paymentMethod");

    orderBody.deliveries = deliveries.cast<Deliveries>();
    orderBody.orderDetails = orderDetails.cast<Order_Details>();
    orderBody.order = order;
    OrderBody requestBody = orderBody;
    print(requestBody.toJson());
    final headers = {'Content-Type': 'application/json'};
    http.Response response = await http.post(Uri.parse('$baseUrl/orders'),
        headers: headers, body: json.encode(requestBody.toJson()));
    dynamic responseData = json.decode(response.body);
    print(responseData["message"]);
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
    } else {
      // Request failed, handle the error
      dynamic responseData = json.decode(response.body);
      print(responseData["message"]);
    }
  }

  Future<double> calculateDeliveryPrice(String? DropoffAddress,
      int? DropoffWardId, String? DeliverAddress, int? DeliverWardId) async {
    String url = '$baseUrl/orders/delivery-price';
    List<CartItem> listCartItems =
        Provider.of<CartProvider>(context, listen: false).cartItems;
    double totalWeight = 0;
    for (var element in listCartItems) {
      if (element.weight != null) {
        totalWeight = totalWeight + element.measurement * element.weight!;
      }
    }
    final Map<String, dynamic> queryParams = {
      'CenterId': await baseController.getInttoSharedPreference("centerId"),
      'TotalWeight': totalWeight,
      'DropoffAddress': DropoffAddress,
      'DropoffWardId': DropoffWardId,
      'DeliverAddress': DeliverAddress,
      'DeliverWardId': DeliverWardId,
      'DeliveryType':
          await baseController.getInttoSharedPreference("deliveryType")
    };

    final response = await http
        .get(Uri.parse(url + '?' + Uri(queryParameters: queryParams).query));
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
      return double.parse(responseData["data"]["deliveryPrice"]);
    } else {
      // Request failed, handle the error
      print(responseData["message"]);

      return 0;
    }
  }
}
