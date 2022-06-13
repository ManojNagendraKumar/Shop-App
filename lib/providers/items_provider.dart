import 'dart:convert';

import 'package:flutter/material.dart';
import './products_file.dart';
import 'package:http/http.dart' as http;

class ItemsProvider with ChangeNotifier {
  List<ProductsFile> _items = [
    // ProductsFile(
    //     id: 'p1',
    //     brand: 'DILLINGER',
    //     description: 'Striped Round-Neck T-shirt',
    //     imageUrl:
    //         'https://assets.ajio.com/medias/sys_master/root/20210403/KJgM/60686309f997dd7b645d301f/-288Wx360H-461085138-green-MODEL.jpg',
    //     price: 540),
    // ProductsFile(
    //     id: 'p2',
    //     brand: 'NETPLAY',
    //     description: 'Heathered Polo T-shirt with Vented Hemline',
    //     imageUrl:
    //         'https://assets.ajio.com/medias/sys_master/root/20210317/QBrL/6051f6937cdb8c1f146588d1/netplay-grey-polo-polo-t-shirt-with-contrast-collar.jpg',
    //     price: 350),
    // ProductsFile(
    //     id: 'p3',
    //     brand: 'LEVIS',
    //     description: 'Graphic Print Crew-Neck T-shirt',
    //     imageUrl:
    //         'https://assets.ajio.com/medias/sys_master/root/20210609/WCAj/60bfbe2ef997ddb312c0dfe0/-1117Wx1400H-460899348-red-MODEL.jpg',
    //     price: 675),
    // ProductsFile(
    //     id: 'p4',
    //     brand: 'PERFORMAX',
    //     description: 'Typographic Print Crew-Neck T-shirt',
    //     imageUrl:
    //         'https://assets.ajio.com/medias/sys_master/root/20210430/n5vi/608c2811aeb269a9e3a688cd/-1117Wx1400H-441110879-pistagreen-MODEL.jpg',
    //     price: 350),
    // ProductsFile(
    //     id: 'p5',
    //     brand: 'NETPLAY',
    //     description: 'Striped Slim Fit Polo T-shirt',
    //     imageUrl:
    //         'https://assets.ajio.com/medias/sys_master/root/20210601/OAML/60b53750aeb269a9e3ceaf02/-473Wx593H-441120228-white-MODEL.jpg',
    //     price: 419),
    // ProductsFile(
    //     id: 'p6',
    //     brand: 'LEVIS',
    //     description: 'Brand Print Crew-Neck T-shirt with Raglan Sleeves',
    //     imageUrl:
    //         'https://assets.ajio.com/medias/sys_master/root/20210205/JIJP/601c4049aeb26969815da033/-1117Wx1400H-460824350-green-MODEL.jpg',
    //     price: 765),
    // ProductsFile(
    //     id: 'p7',
    //     brand: 'PERFORMAX',
    //     description: 'Logo Print Crew-Neck T-shirt',
    //     imageUrl:
    //         'https://assets.ajio.com/medias/sys_master/root/20210115/S1L9/6001afa67cdb8c1f142a2e37/-1117Wx1400H-441110970-darkblue-MODEL.jpg',
    //     price: 360),
    // ProductsFile(
    //     id: 'p8',
    //     brand: 'DILLINGER',
    //     description: 'Colourblock Crew- Neck T-shirt',
    //     imageUrl:
    //         'https://assets.ajio.com/medias/sys_master/root/20211013/uqO3/616622b1f997ddf8f1cd31ca/-473Wx593H-462102870-green-MODEL.jpg',
    //     price: 500),
  ];

  var _isFavorite = false;

  List<ProductsFile> get showOnlyFavorite {
    return _items.where((prod) => prod.isFavorite!).toList();
  }

  ProductsFile findById(String id) {
    return _items.firstWhere((prod) => prod.id == id);
  }

  List<ProductsFile> get items {
    return [..._items];
  }

  Future<void> addItems(Map<String, dynamic> product) async {
    final url = Uri.parse(
        'https://assessment-shop-bf5f4-default-rtdb.firebaseio.com/products.json');

    try {
      final response = await http.post(url,
          body: json.encode({
            'brand': product['brand'],
            'description': product['description'],
            'price': product['price'],
            'imageUrl': product['imageUrl'],
          }));

      _items.add(ProductsFile(
        brand: product['brand'],
        description: product['description'],
        id: json.decode(response.body)['name'],
        imageUrl: product['imageUrl'],
        price: double.parse(product['price']),
      ));
    } catch (error) {
      throw error;
    }
    print('addItems');
    notifyListeners();
  }

  Future<void> updateItems(Map<String, dynamic> product) async {
    final id = product['id'];
    final url = Uri.parse(
        'https://assessment-shop-bf5f4-default-rtdb.firebaseio.com/products/$id.json');

    try {
      await http.patch(url,
          body: json.encode({
            'brand': product['brand'],
            'description': product['description'],
            'price': product['price'],
            'imageUrl': product['imageUrl'],
          }));

      final index = _items.indexWhere((element) => element.id == product['id']);
      _items[index] = ProductsFile(
        brand: product['brand'],
        description: product['description'],
        imageUrl: product['imageUrl'],
        isFavorite: false,
        price: double.parse(product['price']),
      );
    } catch (error) {
      throw error;
    }
    notifyListeners();
  }

  Future<void> fetchAndSetItems() async {
    final url = Uri.parse(
        'https://assessment-shop-bf5f4-default-rtdb.firebaseio.com/products.json');
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      final urlFav = Uri.parse(
          'https://assessment-shop-bf5f4-default-rtdb.firebaseio.com/userFavorites.json');
      final responseFav = await http.get(urlFav);
      final favData = json.decode(responseFav.body);
      final List<ProductsFile> _loadedProducts = [];
      extractedData.forEach((key, value) {
        _loadedProducts.add(ProductsFile(
          id: key,
          brand: value['brand'],
          description: value['description'],
          imageUrl: value['imageUrl'],
          isFavorite: favData == null ? false : favData[key] ?? false,
          price: double.parse(value['price']),
        ));
        _items = _loadedProducts;
      });
    } catch (error) {
      throw error;
    }

    notifyListeners();
  }

  Future<void> deleteItems(String id) async {
    final url = Uri.parse(
        'https://assessment-shop-bf5f4-default-rtdb.firebaseio.com/products/$id.json');
    try {
      await http.delete(url);
      _items.removeWhere((element) => element.id == id);
    } catch (error) {
      throw error;
    }
    notifyListeners();
  }
}
