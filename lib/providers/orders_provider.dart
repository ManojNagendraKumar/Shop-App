import 'dart:convert';

import 'package:assessment2_app/providers/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class OrderItems with ChangeNotifier {
  String? id;
  List<CartItems>? products;
  double? totalAmount;
  DateTime? dateTime;

  OrderItems({this.id, this.products, this.totalAmount, this.dateTime});
}

class Orders with ChangeNotifier {
  List<OrderItems> _orderItems = [];

  List<OrderItems> get orderItems {
    return [..._orderItems];
  }

  Future<void> addOrders(List<CartItems> products, double totalAmount) async {
    final url = Uri.parse(
        'https://assessment-shop-bf5f4-default-rtdb.firebaseio.com/orders.json');
    await http.post(url,
        body: json.encode({
          'dateTime': DateTime.now().toIso8601String(),
          'totalAmount': totalAmount,
          'products': products
              .map((prod) => {
                    'brand': prod.brand,
                    'description': prod.description,
                    'price': prod.price,
                    'imageUrl': prod.imageUrl,
                  })
              .toList(),
        }));
    _orderItems.add(OrderItems(
      products: products,
      totalAmount: totalAmount,
      dateTime: DateTime.now(),
    ));
    notifyListeners();
  }

  Future<void> fetchAndSetOrders() async {
    final url = Uri.parse(
        'https://assessment-shop-bf5f4-default-rtdb.firebaseio.com/orders.json');
    try {
      final response = await http.get(url);
      Map<String, dynamic>? extractedData = json.decode(response.body);

      final List<OrderItems> _loadedOrders = [];
      if (extractedData!.isNotEmpty) {
        extractedData.forEach((key, value) {
          _loadedOrders.add(OrderItems(
            id: key,
            dateTime: DateTime.parse(value['dateTime']),
            totalAmount: value['totalAmount'],
            products: (value['products'] as List<dynamic>)
                .map((items) => CartItems(
                    id: items['id'],
                    brand: items['brand'],
                    description: items['description'],
                    imageUrl: items['imageUrl'],
                    price: items['price']))
                .toList(),
          ));
          _orderItems = _loadedOrders;
        });
      }
    } catch (error) {}
    notifyListeners();
  }
}
