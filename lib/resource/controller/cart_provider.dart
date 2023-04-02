import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/cart_item.dart';

class CartProvidder extends ChangeNotifier {
  Map<int, CartItem> _cart = {};

  late int _counter;
  late String _centerName;
  late double _totalPrice;
  late CartItem _cartSave; //check thử thui

  CartItem get cartSave => _cartSave; //check thử thui
  Map<int, CartItem> get cart => _cart;

  int get counter => _counter;
  String get centerName => _centerName;
  double get totalPrice => _totalPrice;

  void _setPrefItems() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('cart_item', _counter);
    prefs.setDouble('total_price', _totalPrice);
    notifyListeners();
  }

  void _getPrefItems() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _counter = prefs.getInt('cart_item') ?? 0;
    _totalPrice = prefs.getDouble('total_price') ?? 0;
    notifyListeners();
  }

  void _setNameCenter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('center_name', _centerName);
  }

  //có thể viết đè value của key đã có
  void addToCartWithKg(CartItem item) {
    int id = item.service.id!;
    _cart[id] = item;
    notifyListeners();
  }

  //kiểm tra đã có trong cart thì tăng 1, k thì thêm vào cart
  void addToCartWithQuantity(CartItem item) {
    int id = item.service.id!;
    if (_cart.containsKey(id)) {
      _cart[id]?.measurement += 1;
    } else {
      _cart[id]?.measurement = 1;
    }
    notifyListeners();
  }

  //có thì trừ không thì xóa
  void removeFromCartWithQuantity(CartItem item) {
    int id = item.service.id!;
    if (_cart.containsKey(id)) {
      _cart[id]?.measurement -= 1;
    } else {
      clear(id);
    }
    notifyListeners();
  }

  void clear(int serviceId) {
    if (_cart.containsKey(serviceId)) {
      _cart.remove(serviceId);
      notifyListeners();
    }
  }

  void addTotalPrice(double productPrice) {
    _totalPrice = _totalPrice + productPrice;
    _setPrefItems();
    notifyListeners();
  }

  void removeTotalPrice(double productPrice) {
    _totalPrice = _totalPrice - productPrice;
    _setPrefItems();
    notifyListeners();
  }

  num getTotalPrice() {
    _getPrefItems();
    return _totalPrice;
  }

  void addCounter() {
    _counter++;
    _setPrefItems();
    notifyListeners();
  }

  void removerCounter() {
    _counter--;
    _setPrefItems();
    notifyListeners();
  }

  int getCounter() {
    _getPrefItems();
    return _counter;
  }
}
