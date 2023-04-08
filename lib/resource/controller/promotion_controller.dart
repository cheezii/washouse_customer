import 'dart:convert';

import 'package:http/http.dart';
import 'package:washouse_customer/resource/controller/base_controller.dart';
import 'package:washouse_customer/resource/models/promotion.dart';

import '../../components/constants/text_constants.dart';

class PromotionController {
  BaseController baseController = BaseController();

  Future<List<PromotionModel>> getPromotionListOfCenter(int centerId) async {
    List<PromotionModel> promotionList = [];
    try {
      String url = '$baseUrl/promotions/center/$centerId';
      Response response =
          await baseController.makeAuthenticatedRequest(url, {});
      if (response.statusCode == 200) {
        // Handle successful response
        var data = jsonDecode(response.body)['data'] as List;
        promotionList = data.map((e) => PromotionModel.fromJson(e)).toList();
        print(promotionList.length);
        promotionList = promotionList
            .where((element) => element.isAvailable == true)
            .toList();
        print(promotionList.length);
      } else {
        // Handle error response
        throw Exception('Error fetching user data: ${response.statusCode}');
      }
    } catch (e) {
      print('error: getPromotionListOfCenter-$e');
      throw e;
    }
    return promotionList;
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
