import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CartItems {
  String? id;
  String? brand;
  String? description;
  double? price;
  int? quantity;
  String? imageUrl;

  CartItems(
      {this.brand,
      this.description,
      this.id,
      this.price,
      this.quantity,
      this.imageUrl});
}

class Cart with ChangeNotifier {
  Map<String, CartItems> _cartItems = {};

  Map<String, CartItems> get cartItems {
    return {..._cartItems};
  }

  void addItems(String? productId, String? brand, String? description,
      double? price, int? quantity, String? imageUrl) {
    if (_cartItems.containsKey(productId)) {
      _cartItems.update(
          productId!,
          (existingValue) => CartItems(
              brand: existingValue.brand,
              description: existingValue.description,
              id: existingValue.id,
              price: existingValue.price,
              quantity: (existingValue.quantity! + 1),
              imageUrl: existingValue.imageUrl));
    } else {
      _cartItems.putIfAbsent(
          productId!,
          () => CartItems(
                brand: brand,
                description: description,
                price: price,
                quantity: 1,
                imageUrl: imageUrl,
              ));
    }
    notifyListeners();
  }

  void removeItems(String productId) {
    _cartItems.remove(productId);
    notifyListeners();
  }

  void emptyCartItems() {
    _cartItems = {};
    notifyListeners();
  }

  double get totalAmount {
    var total = 0.0;
    _cartItems.forEach((productId, CartItems) {
      total += CartItems.price! * CartItems.quantity!;
    });
    return total;
  }
}
