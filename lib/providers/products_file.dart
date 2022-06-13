import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProductsFile with ChangeNotifier {
  final String? id;
  final String? brand;
  final String? description;
  final String? imageUrl;
  final double? price;
  bool? isFavorite;

  ProductsFile(
      {this.id,
      this.brand,
      this.description,
      this.imageUrl,
      this.price,
      this.isFavorite = false});

  Future<void> showFavorites(String id) async {
    isFavorite = !isFavorite!;
    notifyListeners();
    final url = Uri.parse(
        'https://assessment-shop-bf5f4-default-rtdb.firebaseio.com/userFavorites/$id.json');
    await http.put(url, body: json.encode(isFavorite));
    notifyListeners();
  }
}
