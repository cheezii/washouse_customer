import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:washouse_customer/resource/models/promotion.dart';
import 'package:washouse_customer/utils/cart_util.dart';

import '../models/cart_item.dart';

class CartProvider extends ChangeNotifier {
  List<CartItem> _cartItems = [];
  //late int _counter;
  int? _centerId = 0;
  double _totalPrice = 0;
  double _discount = 0;
  double _deliveryPrice = 0;
  int _deliveryType = 0;
  String? _promoCode = '';

  List<CartItem> get cartItems => _cartItems;

  //int get counter => _counter;
  int? get centerId => _centerId;
  double get totalPrice => _totalPrice;
  double get discount => _discount;
  double get deliveryPrice => _deliveryPrice;
  int get deliveryType => _deliveryType;
  String? get promoCode => _promoCode;

  CartProvider() {
    loadCartItemsFromPrefs();
  }

  Future<void> loadCartItemsFromPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? cartItemsJson = prefs.getString('cartItems');
    //String? centerName = prefs.getString('centerName');
    if (cartItemsJson != null) {
      List<dynamic> cartItemsDynamic = jsonDecode(cartItemsJson);
      _cartItems = cartItemsDynamic.map((item) => CartItem.fromJson(item)).toList();
      notifyListeners();
    }
  }

  void addItemToCart(CartItem newItem) {
    int existingItemIndex = _cartItems.indexWhere((item) => item.serviceId == newItem.serviceId);
    if (existingItemIndex == -1) {
      newItem.price = CartUtils.getTotalPriceOfCartItem(newItem);
      print('newItem.price:${newItem.price}');
      addTotalPrice(newItem.price!);
      _cartItems.add(newItem);
      print('_totalPrice:${_totalPrice}');
    } else {
      CartItem existingItem = _cartItems[existingItemIndex];
      if (newItem.priceType) {
        double totalMeasurement = existingItem.measurement + newItem.measurement;
        double maxCapacity = newItem.prices!.last.maxValue!.toDouble();
        if (totalMeasurement <= maxCapacity) {
          newItem.measurement = totalMeasurement;
          newItem.price = CartUtils.getTotalPriceOfCartItem(newItem);
        } else {
          newItem.measurement = maxCapacity;
          newItem.price = CartUtils.getTotalPriceOfCartItem(newItem);
          print("Measurement capacity exceeded for item with serviceId ${existingItem.serviceId}");
        }
      } else {
        newItem.measurement = newItem.measurement + existingItem.measurement;
        newItem.price = CartUtils.getTotalPriceOfCartItem(newItem);
      }
      removeTotalPrice(existingItem.price!);
      _cartItems.removeAt(existingItemIndex);
      addTotalPrice(newItem.price!);
      _cartItems.add(newItem);
    }
    notifyListeners();
    saveCartItemsToPrefs();
  }

  void removeItemFromCart(CartItem itemToRemove) {
    int existingItemIndex = _cartItems.indexWhere((item) => item.serviceId == itemToRemove.serviceId);
    removeTotalPrice(_cartItems[existingItemIndex].price!);
    _cartItems.remove(_cartItems[existingItemIndex]);
    if (_cartItems.length == 0) {
      _discount = 0;
      _deliveryPrice = 0;
      _totalPrice = 0;
      _promoCode = "";
      _clearIfCartEmpty();
    }
    notifyListeners();
    saveCartItemsToPrefs();
  }

  Future<void> saveCartItemsToPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<dynamic> cartItemsDynamic = _cartItems.map((item) => item.toJson()).toList();
    String cartItemsJson = jsonEncode(cartItemsDynamic);
    print(cartItemsJson);
    if (!cartItemsJson.isEmpty) await prefs.setString('cartItems', cartItemsJson);
  }

  void _setPrefItems() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //prefs.setInt('cart_item', _counter);
    prefs.setDouble('total_price', _totalPrice);
    notifyListeners();
  }

  void _clearIfCartEmpty() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //prefs.setInt('cart_item', _counter);
    await prefs.remove('centerId');
    await prefs.setDouble('total_price', 0);
    await prefs.remove('discount');
    await prefs.remove('customerName');
    await prefs.remove('customerAddressString');
    await prefs.remove('customerMessage');
    await prefs.remove('customerWardId');
    await prefs.remove('paymentMethod');
    await prefs.remove('deliveryType');
    await prefs.remove('preferredDropoffTime');
    await prefs.remove('preferredDropoffTime_Date');
    await prefs.remove('preferredDropoffTime_Time');
    await prefs.remove('preferredDeliverTime_Time');
    await prefs.remove('preferredDeliverTime_Date');
    await prefs.remove('addressString_Dropoff');
    await prefs.remove('addressString_Delivery');
    await prefs.remove('wardId_Dropoff');
    await prefs.remove('wardId_Delivery');
    await prefs.remove('promoCode');
    await prefs.remove('customerPhone');
    await prefs.remove('customerNote');
    await prefs.remove('cartItems');
    await prefs.remove('deliveryPrice');
    await prefs.remove('total_price');
    await prefs.remove('customerNote');
    await prefs.remove('centerId');
    await prefs.remove('customerName');
    await prefs.remove('customerPhone');
    await prefs.remove('customerWardId');
    await prefs.remove('deliveryType');
    await prefs.remove('addressString_Dropoff');
    await prefs.remove('customerMessage');
    await prefs.remove('paymentMethod');
    //notifyListeners();
  }

  void _getPrefItems() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //_counter = prefs.getInt('cart_item') ?? 0;
    _totalPrice = prefs.getDouble('total_price') ?? 0;
    notifyListeners();
  }

  void updateCenter(int id) {
    if (_centerId != id) {
      _centerId = id;
    }
    notifyListeners();
    _setCenter();
  }

  void updatePromotion(PromotionModel promotion) {
    if (_promoCode != promotion.code) {
      _promoCode = promotion.code;
    }
    if (_discount != promotion.discount) {
      _discount = promotion.discount;
    }
    print(_promoCode);
    notifyListeners();
    _setPromotion();
  }

  Future removeCart() async {
    _cartItems.clear();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('cartItems');
    _discount = 0;
    _deliveryPrice = 0;
    _totalPrice = 0;
    _promoCode = "";
    _deliveryType = 0;
    await prefs.remove('centerId');
    await prefs.setDouble('total_price', 0);
    await prefs.remove('discount');
    await prefs.remove('customerName');
    await prefs.remove('customerAddressString');
    await prefs.remove('customerMessage');
    await prefs.remove('customerWardId');
    await prefs.remove('paymentMethod');
    await prefs.remove('deliveryType');
    await prefs.remove('preferredDropoffTime');
    await prefs.remove('preferredDropoffTime_Date');
    await prefs.remove('preferredDropoffTime_Time');
    await prefs.remove('preferredDeliverTime_Time');
    await prefs.remove('preferredDeliverTime_Date');
    await prefs.remove('addressString_Dropoff');
    await prefs.remove('addressString_Delivery');
    await prefs.remove('wardId_Dropoff');
    await prefs.remove('wardId_Delivery');
    await prefs.remove('promoCode');
    await prefs.remove('customerPhone');
    await prefs.remove('customerNote');
    await prefs.remove('cartItems');
    await prefs.remove('deliveryPrice');
    await prefs.remove('total_price');
    await prefs.remove('customerNote');
    await prefs.remove('centerId');
    await prefs.remove('customerName');
    await prefs.remove('customerPhone');
    await prefs.remove('customerWardId');
    await prefs.remove('deliveryType');
    await prefs.remove('addressString_Dropoff');
    await prefs.remove('customerMessage');
    await prefs.remove('paymentMethod');
    //_clearIfCartEmpty();
    notifyListeners();
    _setCenter();
  }

  void _setCenter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('centerId', _centerId);
  }

  void _getCenter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _centerId = prefs.getInt('centerId') ?? null;
  }

  void _setPromotion() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('promoCode', _promoCode);
    prefs.setDouble('discount', _discount);
  }

  void _getPromotion() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _promoCode = prefs.getString('promoCode');
    _discount = prefs.getDouble('discount');
  }

  void _setDeliveryPrice() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _deliveryPrice = prefs.getDouble('deliveryPrice');
    _deliveryType = prefs.getInt("deliveryType");
  }

  void _getDeliveryPrice() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _deliveryPrice = prefs.getDouble('deliveryPrice');
    _deliveryType = prefs.getInt('deliveryType');
  }

  void updateDeliveryPrice() {
    notifyListeners();
    _setDeliveryPrice();
  }

  void addTotalPrice(double productPrice) {
    print('productPrice-${productPrice}'); //35
    print('_totalPrice-${_totalPrice}'); //0
    _totalPrice += productPrice;
    //(_totalPrice + productPrice) > 0 ? (_totalPrice + productPrice) : 0;
    print('_totalPriceAfter-${_totalPrice}');
    _setPrefItems();
    notifyListeners();
  }

  void removeTotalPrice(double productPrice) {
    print('productPriceRemove-${productPrice}');
    print('_totalPriceRemove-${_totalPrice}'); //0
    print('_Remove-${(_totalPrice - productPrice)}'); //0
    _totalPrice = (_totalPrice - productPrice) > 0 ? _totalPrice - productPrice : 0;
    print('_totalPriceAfterRemove-${_totalPrice}');
    _setPrefItems();
    notifyListeners();
  }

  num getTotalPrice() {
    _getPrefItems();
    return _totalPrice;
  }

  void addCounter() {
    //_counter++;
    _setPrefItems();
    notifyListeners();
  }

  void removerCounter() {
    //_counter--;
    _setPrefItems();
    notifyListeners();
  }

  //kiểm tra đã có trong cart thì tăng 1, k thì thêm vào cart
  void addToCartWithQuantity(CartItem cart_item) {
    int existingItemIndex = _cartItems.indexWhere((item) => item.serviceId == cart_item.serviceId);
    CartItem existingItem = _cartItems[existingItemIndex];
    if (cart_item.priceType) {
      double totalMeasurement = existingItem.measurement + 1;
      double maxCapacity = cart_item.prices!.last.maxValue!.toDouble();
      if (totalMeasurement <= maxCapacity) {
        cart_item.measurement = totalMeasurement;
        cart_item.price = CartUtils.getTotalPriceOfCartItem(cart_item);
      } else {
        cart_item.measurement = maxCapacity;
        cart_item.price = CartUtils.getTotalPriceOfCartItem(cart_item);
        print("Measurement capacity exceeded for item with serviceId ${existingItem.serviceId}");
      }
    } else {
      cart_item.measurement = 1 + existingItem.measurement;
      cart_item.price = CartUtils.getTotalPriceOfCartItem(cart_item);
    }
    removeTotalPrice(existingItem.price!);
    _cartItems.removeAt(existingItemIndex);
    addTotalPrice(cart_item.price!);
    _cartItems.add(cart_item);
    notifyListeners();
    saveCartItemsToPrefs();
  }

  //có thì trừ không thì xóa
  void removeFromCartWithQuantity(CartItem cart_item) {
    int existingItemIndex = _cartItems.indexWhere((item) => item.serviceId == cart_item.serviceId);
    CartItem existingItem = _cartItems[existingItemIndex];
    removeTotalPrice(existingItem.price!);
    cart_item.measurement = existingItem.measurement - 1;
    cart_item.price = CartUtils.getTotalPriceOfCartItem(cart_item);
    _cartItems.removeAt(existingItemIndex);

    addTotalPrice(cart_item.price!);
    _cartItems.add(cart_item);
    notifyListeners();
    saveCartItemsToPrefs();
  }

  void addToCartWithKilogram(CartItem cart_item) {
    int existingItemIndex = _cartItems.indexWhere((item) => item.serviceId == cart_item.serviceId);
    CartItem existingItem = _cartItems[existingItemIndex];
    if (cart_item.priceType) {
      double totalMeasurement = double.parse((existingItem.measurement + 0.1).toStringAsFixed(1));
      double maxCapacity = cart_item.prices!.last.maxValue!.toDouble();
      if (totalMeasurement <= maxCapacity) {
        cart_item.measurement = totalMeasurement;
        cart_item.price = CartUtils.getTotalPriceOfCartItem(cart_item);
      } else {
        cart_item.measurement = maxCapacity;
        cart_item.price = CartUtils.getTotalPriceOfCartItem(cart_item);
        print("Measurement capacity exceeded for item with serviceId ${existingItem.serviceId}");
      }
    } else {
      cart_item.measurement = double.parse((0.1 + existingItem.measurement).toStringAsFixed(1));
      cart_item.price = CartUtils.getTotalPriceOfCartItem(cart_item);
    }
    removeTotalPrice(existingItem.price!);
    _cartItems.removeAt(existingItemIndex);
    addTotalPrice(cart_item.price!);
    _cartItems.add(cart_item);
    notifyListeners();
    saveCartItemsToPrefs();
  }

  void removeFromCartWithKilogram(CartItem cart_item) {
    int existingItemIndex = _cartItems.indexWhere((item) => item.serviceId == cart_item.serviceId);
    CartItem existingItem = _cartItems[existingItemIndex];
    removeTotalPrice(existingItem.price!);
    cart_item.measurement = double.parse((existingItem.measurement - 0.1).toStringAsFixed(1));
    cart_item.price = CartUtils.getTotalPriceOfCartItem(cart_item);
    _cartItems.removeAt(existingItemIndex);

    addTotalPrice(cart_item.price!);
    _cartItems.add(cart_item);
    notifyListeners();
    saveCartItemsToPrefs();
  }
}
