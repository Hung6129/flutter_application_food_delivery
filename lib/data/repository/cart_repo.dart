import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../custom/app_constants.dart';
import '../../model/cart_model.dart';

class CartRepo {
  final SharedPreferences share;
  CartRepo({required this.share});

  List<String> cart = [];
  List<String> cartHistory = [];

  void addToCart(List<CartModel> cartList) {
    // share.remove(AppConstants.CART_LIST);
    // share.remove(AppConstants.CART_HISTORY_LIST);

    var time = DateTime.now().toString();
    cart = [];
    cartList.forEach((element) {
      element.time = time;
      return cart.add(jsonEncode(element));
    });
    share.setStringList(AppConstants.CART_LIST, cart);
    // getCartModel();
    // print(share.getStringList(AppConstants.CART_LIST));
  }

  List<CartModel> getCartModel() {
    List<String> carts = [];
    if (share.containsKey(AppConstants.CART_LIST)) {
      carts = share.getStringList(AppConstants.CART_LIST)!;
      print("inside getCartModel" + carts.toString());
    }
    List<CartModel> cartList = [];
    carts.forEach((element) {
      cartList.add(CartModel.fromJson(jsonDecode(element)));
    });
    return cartList;
  }

  List<CartModel> getCartHistoryList() {
    if (share.containsKey(AppConstants.CART_HISTORY_LIST)) {
      cartHistory = [];
      cartHistory = share.getStringList(AppConstants.CART_HISTORY_LIST)!;
    }
    List<CartModel> cartListHistory = [];
    cartHistory.forEach((element) {
      cartListHistory.add(CartModel.fromJson(jsonDecode(element)));
    });
    return cartListHistory;
  }

  void addToCartHistory() {
    if (share.containsKey(AppConstants.CART_HISTORY_LIST)) {
      cartHistory = share.getStringList(AppConstants.CART_HISTORY_LIST)!;
    }
    for (int i = 0; i < cart.length; i++) {
      print("list" + cart[i]);
      cartHistory.add(cart[i]);
    }
    removeCart();
    share.setStringList(AppConstants.CART_HISTORY_LIST, cartHistory);
    print(getCartHistoryList().length.toString());
    print(getCartHistoryList()[0].time.toString());
  }

  void removeCart() {
    cart = [];
    share.remove(AppConstants.CART_LIST);
  }
}
