import 'dart:convert';

import 'package:http/http.dart';

import '../../components/constants/text_constants.dart';
import '../models/service.dart';

class ServiceController {
  List<Service> serviceList = [];
  Future<List<Service>> getServiceListByCenterId(int centerID) async {
    Response response =
        await get(Uri.parse('$baseUrl/centers/$centerID/services'));
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
}
