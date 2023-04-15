// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import '../resource/models/cart_item.dart';

// class CartUtils {
//   static const CART_KEY = 'cart_items';

//   static Future<List<CartItem>> loadCart() async {
//     final prefs = await SharedPreferences.getInstance();
//     final cartJson = prefs.getString(CART_KEY);
//     if (cartJson != null) {
//       final cartData = json.decode(cartJson) as List<dynamic>;
//       return cartData.map((item) => CartItem.fromJson(item)).toList();
//     } else {
//       return [];
//     }
//   }

//   static Future<void> addItem(CartItem item) async {
//     final cart = await loadCart();
//     cart.add(item);
//     final prefs = await SharedPreferences.getInstance();
//     final cartJson = json.encode(cart.map((item) => item.toJson()).toList());
//     await prefs.setString(CART_KEY, cartJson);
//   }

//   static Future<void> removeItem(CartItem item) async {
//     final cart = await loadCart();
//     cart.removeWhere((cartItem) => cartItem.serviceId == item.serviceId);
//     final prefs = await SharedPreferences.getInstance();
//     final cartJson = json.encode(cart.map((item) => item.toJson()).toList());
//     await prefs.setString(CART_KEY, cartJson);
//   }

//   static Future<void> updateMeasurement(
//       int serviceId, double newMeasurement) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String cartString = prefs.getString('cart') ?? '';
//     if (cartString.isNotEmpty) {
//       List<dynamic> cartJson = jsonDecode(cartString);
//       List<CartItem> cartItems =
//           cartJson.map((item) => CartItem.fromJson(item)).toList();
//       int index = cartItems.indexWhere((item) => item.serviceId == serviceId);
//       if (index != -1) {
//         cartItems[index].measurement = newMeasurement;
//         cartJson = cartItems.map((item) => item.toJson()).toList();
//         String newCartString = jsonEncode(cartJson);
//         prefs.setString('cart', newCartString);
//       }
//     }
//   }
// }
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../resource/models/cart_item.dart';

class CartUtils {
  static double getTotalPriceOfCartItem(CartItem item) {
    double currentPrice = 0;
    double totalCurrentPrice = 0;
    if (item.priceType) {
      bool check = false;
      for (var itemPrice in item.prices!) {
        if (item.measurement <= itemPrice.maxValue! && !check) {
          currentPrice = itemPrice.price!.toDouble();
        }
        if (currentPrice > 0) {
          check = true;
        }
      }
      print('currentPrice-${currentPrice}');
      print('item.minPrice-${item.minPrice}');
      if (item.minPrice != null && currentPrice * item.measurement < item.minPrice!) {
        totalCurrentPrice = item.minPrice!.toDouble();
      } else {
        totalCurrentPrice = currentPrice * item.measurement;
      }
      print('totalCurrentPrice-${totalCurrentPrice}');
    } else {
      totalCurrentPrice = item.unitPrice! * item.measurement.toDouble();
      currentPrice = item.price!.toDouble();
    }

    print(totalCurrentPrice);
    return totalCurrentPrice;
  }
}
