import 'dart:convert';

import 'package:http/http.dart';

import '../../components/constants/text_constants.dart';

class MapUserController {
  Future getCurrentLocation(
      double lat1, double long1, double lat2, long2) async {
    Response response = await get(Uri.parse(
        '$baseUrl/locations/distance?Latitude_1=$lat1&Longitude_1=$long1&Latitude_2=$lat2&Longitude_2=$long2'));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data']['distance'] as double;
      return data;
    } else {
      throw Exception("Lỗi khi load Json");
    }
  }
}
