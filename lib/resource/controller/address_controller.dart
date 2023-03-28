import 'dart:convert';

import 'package:http/http.dart';

import '../../components/constants/text_constants.dart';

class AddressController {
  Future<List> getDistrictList() async {
    List districtList = [];
    Response response = await get(Uri.parse('$baseUrl/districts'));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      districtList = data['data'];
    } else {
      throw Exception("Lỗi khi load Json");
    }
    return districtList;
  }

  Future getWardsList(int id) async {
    List wardList = [];
    Response response = await get(Uri.parse('$baseUrl/districts/$id/wards'));
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      wardList = data['data'];
      print(wardList);
    } else {
      throw Exception("Lỗi khi load Json");
    }
    return wardList;
  }
}
