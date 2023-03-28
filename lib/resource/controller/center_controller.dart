import 'dart:convert';

import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart';
import 'package:washouse_customer/resource/models/center.dart';

import '../../components/constants/text_constants.dart';

class CenterController {
  Future<List<LaundryCenter>> getCenterList() async {
    Response response = await get(Uri.parse('$baseUrl/centers'));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data']['items'] as List;
      List<LaundryCenter> centerList =
          data.map((e) => LaundryCenter.fromJson(e)).toList();
      return centerList;
    } else {
      throw Exception("Lỗi khi load Json");
    }
  }

  Future<List<LaundryCenter>> getCenterListSearch(String query) async {
    Response response =
        await get(Uri.parse('$baseUrl/centers?SearchString=$query'));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data']['items'] as List;
      List<LaundryCenter> centerList =
          data.map((e) => LaundryCenter.fromJson(e)).toList();
      return centerList;
    } else {
      throw Exception("Lỗi khi load Json");
    }
  }

  Future<List<LaundryCenter>> getCenterNearby() async {
    Position position = await Geolocator.getCurrentPosition();
    double lat = position.latitude;
    double long = position.longitude;
    Response response = await get(Uri.parse(
        '$baseUrl/centers?CurrentUserLatitude=$lat&CurrentUserLongitude=$long'));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data']['items'] as List;
      List<LaundryCenter> centerList =
          data.map((e) => LaundryCenter.fromJson(e)).toList();
      return centerList;
    } else {
      throw Exception("Lỗi khi load Json");
    }
  }
}
