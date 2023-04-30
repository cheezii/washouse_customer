import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart';
import 'package:washouse_customer/resource/models/map_user.dart';

import '../../components/constants/text_constants.dart';

class MapUserController {
  Future<MapUser> getCurrentLocation(double lat, double long) async {
    Response response = await get(Uri.parse('$baseUrl/maps/location?latitude=$lat&longitude=$long'));
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      return MapUser.fromJson(data);
    } else {
      throw Exception("Lỗi khi load Json");
    }
  }

  Future<bool> handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      showDialog('Location services are disabled. Please enable the services');
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        showDialog('Location permissions are denied');
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      showDialog('Location permissions are permanently denied, we cannot request permissions.');
      return false;
    }
    return true;
  }

  AlertDialog showDialog(String text) {
    return AlertDialog(
      title: const Text('Oops'),
      content: Text(text),
    );
  }
}
