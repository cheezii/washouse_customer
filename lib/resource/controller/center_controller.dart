import 'dart:async';
import 'dart:convert';

import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart';
import 'package:washouse_customer/resource/models/center.dart';
import 'package:washouse_customer/resource/models/response_models/center_response_model.dart';

import '../../components/constants/text_constants.dart';

class CenterController {
  List<LaundryCenter> centerList = [];

  // Future<List<LaundryCenter>> getCenterList() async {
  //   Response response = await get(Uri.parse('$baseUrl/centers'));
  //   try {
  //     if (response.statusCode == 200) {
  //       var data = jsonDecode(response.body)['data']['items'] as List;

  //       centerList = data.map((e) => LaundryCenter.fromJson(e)).toList();
  //     } else {
  //       throw Exception("Lỗi khi load Json");
  //     }
  //   } catch (e) {
  //     print('error: $e');
  //   }
  //   return centerList;
  // }

  Future<List<LaundryCenter>> getCenterList(
      String? searchString,
      String? sortSring,
      String? min,
      String? max,
      String? categoryService) async {
    Position position = await Geolocator.getCurrentPosition();
    double lat = position.latitude;
    double long = position.longitude;
    Response response = await get(Uri.parse(
        '$baseUrl/centers?Sort=$sortSring&BudgetRange=$min-$max&CategoryServices=$categoryService&SearchString=$searchString&CurrentUserLatitude=$lat&CurrentUserLongitude=$long'));
    //print(response.body);
    CenterResponseModel body = jsonDecode(response.body);
    try {
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body)['data']['items'] as List;
        //print(data);
        centerList = data.map((e) => LaundryCenter.fromJson(e)).toList();
      } else {
        throw Exception("Lỗi khi load Json");
      }
    } catch (e) {
      print('error: $e');
    }
    return centerList;
  }

  Future<String?> getResponseMessage(String? searchString, String? sortSring,
      String? min, String? max, String? categoryService) async {
    Position position = await Geolocator.getCurrentPosition();
    double lat = position.latitude;
    double long = position.longitude;
    Response response = await get(Uri.parse(
        '$baseUrl/centers?Sort=$sortSring&BudgetRange=$min-$max&CategoryServices=$categoryService&SearchString=$searchString&CurrentUserLatitude=$lat&CurrentUserLongitude=$long'));
    //print(response.body);
    var body = jsonDecode(response.body);
    CenterResponseModel responseModel = CenterResponseModel.fromJson(body);
    print(responseModel.message);
    try {
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body)['data']['items'] as List;
        //print(data);
        centerList = data.map((e) => LaundryCenter.fromJson(e)).toList();
      } else {
        throw Exception("${responseModel.message}");
      }
    } catch (e) {
      print('error: $e');
    }
    return responseModel.message;
  }

  Future<List<LaundryCenter>> getCenterNearby() async {
    Position position = await Geolocator.getCurrentPosition();
    double lat = position.latitude;
    double long = position.longitude;
    Response response = await get(Uri.parse(
        '$baseUrl/centers?CurrentUserLatitude=$lat&CurrentUserLongitude=$long'));
    try {
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body)['data']['items'] as List;
        centerList = data.map((e) => LaundryCenter.fromJson(e)).toList();
      } else {
        throw Exception("Lỗi khi load Json");
      }
    } catch (e) {
      print('error: $e');
    }
    return centerList;
  }
}
