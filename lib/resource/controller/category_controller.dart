import 'dart:convert';

import 'package:http/http.dart';
import 'package:washouse_customer/resource/models/category.dart';

import '../../components/constants/text_constants.dart';

class CategoryController {
  List<ServiceCategory> cateList = [];
  Future<List<ServiceCategory>> getCategoriesList() async {
    Response response = await get(Uri.parse('$baseUrl/service-categories'));
    try {
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body) as List;
        print(data);
        cateList = data.map((e) => ServiceCategory.fromJson(e)).toList();
      } else {
        throw Exception("Lỗi khi load Json");
      }
    } catch (e) {
      print('error: $e');
    }
    return cateList;
  }
}
