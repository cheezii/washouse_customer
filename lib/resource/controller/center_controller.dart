import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:geolocator/geolocator.dart';
import 'package:washouse_customer/resource/models/current_user.dart';
import 'package:washouse_customer/resource/controller/base_controller.dart';
import 'package:washouse_customer/resource/models/center.dart';
import 'package:washouse_customer/resource/models/request_models/filter_center_model.dart';
import 'package:washouse_customer/resource/models/response_models/center_response_model.dart';

import '../../components/constants/text_constants.dart';

BaseController baseController = BaseController();

class CenterController {
  List<LaundryCenter> centerList = [];
  //     } else {
  //       throw Exception("Lỗi khi load Json");
  //     }
  //   } catch (e) {
  //     print('error: $e');
  //   }
  //   return centerList;
  // }

  Future<List<LaundryCenter>> getCenterList(FilterCenterRequest filter) async {
    Position position = await Geolocator.getCurrentPosition();
    filter.currentUserLatitude = position.latitude;
    filter.currentUserLongitude = position.longitude;
    filter.page = 1;
    filter.pageSize = 1000;
    filter.hasDelivery = true;
    final queryParameters = {
      'page': filter.page?.toString(),
      'pageSize': filter.pageSize?.toString(),
      'sort': filter.sort,
      'budgetRange': filter.budgetRange,
      'categoryServices': filter.categoryServices,
      'additions': filter.additions,
      'searchString': filter.searchString,
      'hasDelivery': filter.hasDelivery?.toString(),
      'currentUserLatitude': filter.currentUserLatitude?.toString(),
      'currentUserLongitude': filter.currentUserLongitude?.toString(),
    };

    try {
      final url = "$baseUrl/centers";
      final response =
          await baseController.makeAuthenticatedRequest(url, queryParameters);
      //print(url);
      //print(queryParameters);
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body)['data']['items'] as List;
        // Handle successful response
        centerList = data.map((e) => LaundryCenter.fromJson(e)).toList();
        // Do something with the user data...
      } else {
        // Handle error response
        throw Exception('Error fetching user data: ${response.statusCode}');
      }
    } catch (e) {
      print('error: getCenters-$e');
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
        '$baseUrl/centers?Sort=location&CurrentUserLatitude=$lat&CurrentUserLongitude=$long'));
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
