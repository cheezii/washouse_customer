import 'dart:convert';

import 'package:http/http.dart';
import 'package:washouse_customer/resource/models/map_user.dart';

import '../../components/constants/text_constants.dart';

class MapUserController {
  Future<MapUser> getCurrentLocation(double lat, double long) async {
    Response response = await get(
        Uri.parse('$baseUrl/maps/location?latitude=$lat&longitude=$long'));
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      return MapUser.fromJson(data);
    } else {
      throw Exception("Lỗi khi load Json");
    }
  }
}
