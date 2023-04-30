import 'dart:convert';

import 'package:http/http.dart';

import '../../components/constants/text_constants.dart';
import '../models/service.dart';
import 'base_controller.dart';

BaseController baseController = BaseController();

class ServiceController {
  List<Service> serviceList = [];
  Future<List<Service>> getServiceListByCenterId(int centerID) async {
    Response response = await get(Uri.parse('$baseUrl/centers/$centerID/services'));
    try {
      var data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        var body = data['data'] as List;
        serviceList = body.map((e) => Service.fromJson(e)).toList();
      } else {
        print(data['message']);
      }
    } catch (e) {
      print('error: $e');
    }
    return serviceList;
  }

  Future<Service> getServiceById(int serviceId) async {
    Service service = Service();
    try {
      final url = "$baseUrl/services/$serviceId";
      final response = await baseController.makeAuthenticatedRequest(url, {});
      //print(url);
      //print(queryParameters);
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body)['data'];
        // Handle successful response
        service = Service.fromJson(data);
        // Do something with the user data...
      } else {
        // Handle error response
        throw Exception('Error fetching service data: ${response.statusCode}');
      }
    } catch (e) {
      print('error: getCenterDetail: $e');
    }
    return service;
  }
}
