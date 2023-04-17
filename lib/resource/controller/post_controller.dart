import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:washouse_customer/resource/controller/base_controller.dart';
import '../../components/constants/text_constants.dart';
import '../models/post.dart';

BaseController baseController = BaseController();

class PostController {
  Future<List<Post>> getPosts() async {
    List<Post> posts = [];
    try {
      String url = '$baseUrl/posts';
      final Uri uri = Uri.parse(url);
      final Map<String, String> queryParams = {};
      final response = await http.get(uri.replace(queryParameters: queryParams));
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body)['data']['items'] as List;
        // Handle successful response
        posts = data.map((e) => Post.fromJson(e)).toList();
      } else {
        throw Exception('Error fetching getPosts: ${response.statusCode}');
      }
    } catch (e) {
      print('error: getPosts-$e');
    }
    return posts;
  }
}
