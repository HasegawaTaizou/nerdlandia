import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:projeto_nerdlandia/exceptions/http_exception.dart';
import 'package:projeto_nerdlandia/models/game.dart';
import 'package:projeto_nerdlandia/utils/constants.dart';

class GameList with ChangeNotifier {
  final String _token;
  final String _userId;
  List<Game> _items = [];

  List<Game> get items => [..._items];
  List<Game> get favoriteItems =>
      _items.where((prod) => prod.isFavorite).toList();

  GameList([
    this._token = '',
    this._userId = '',
    this._items = const [],
  ]);

  int get itemsCount {
    return _items.length;
  }

  Future<void> loadProducts() async {
    _items.clear();

    final response = await http.get(
      Uri.parse('${Constants.PRODUCT_BASE_URL}.json?auth=$_token'),
    );
    if (response.body == 'null') return;

    final favResponse = await http.get(
      Uri.parse(
        '${Constants.USER_FAVORITES_URL}/$_userId.json?auth=$_token',
      ),
    );

    Map<String, dynamic> favData =
        favResponse.body == 'null' ? {} : jsonDecode(favResponse.body);

    Map<String, dynamic> data = jsonDecode(response.body);
    data.forEach((productId, productData) {
      final isFavorite = favData[productId] ?? false;
      _items.add(
        Game(
          id: productId,
          name: productData['name'],
          description: productData['description'],
          price: productData['price'],
          imageUrl: productData['imageUrl'],
          platformType: productData['platformType'],
          ageRestriction: productData['ageRestriction'],
          gender: productData['gender'],
          isFavorite: isFavorite,
        ),
      );
    });
    notifyListeners();
  }

  Future<void> saveProduct(Map<String, Object> data) {
    bool hasId = data['id'] != null;

    final product = Game(
      id: hasId ? data['id'] as String : Random().nextDouble().toString(),
      name: data['name'] as String,
      description: data['description'] as String,
      price: data['price'] as double,
      imageUrl: data['imageUrl'] as String,
      platformType: data['platformType'] as String,
      ageRestriction: data['ageRestriction'] as String,
      gender: data['gender'] as String,
    );

    if (hasId) {
      return updateProduct(product);
    } else {
      return addProduct(product);
    }
  }

  Future<void> addProduct(Game product) async {
    final response = await http.post(
      Uri.parse('${Constants.PRODUCT_BASE_URL}.json?auth=$_token'),
      body: jsonEncode(
        {
          "name": product.name,
          "description": product.description,
          "price": product.price,
          "imageUrl": product.imageUrl,
          "platformType": product.platformType,
          "ageRestriction": product.ageRestriction,
          "gender": product.gender,
        },
      ),
    );

    final id = jsonDecode(response.body)['name'];
    _items.add(Game(
      id: id,
      name: product.name,
      description: product.description,
      price: product.price,
      imageUrl: product.imageUrl,
      platformType: product.platformType,
      ageRestriction: product.ageRestriction,
      gender: product.gender,
    ));
    notifyListeners();
  }

  Future<void> updateProduct(Game product) async {
    int index = _items.indexWhere((p) => p.id == product.id);

    if (index >= 0) {
      await http.patch(
        Uri.parse(
          '${Constants.PRODUCT_BASE_URL}/${product.id}.json?auth=$_token',
        ),
        body: jsonEncode(
          {
            "name": product.name,
            "description": product.description,
            "price": product.price,
            "imageUrl": product.imageUrl,
            "platformType": product.platformType,
            "ageRestriction": product.ageRestriction,
            "gender": product.gender,
          },
        ),
      );

      _items[index] = product;
      notifyListeners();
    }
  }

  Future<void> removeProduct(Game product) async {
    int index = _items.indexWhere((p) => p.id == product.id);

    if (index >= 0) {
      final product = _items[index];
      _items.remove(product);
      notifyListeners();

      final response = await http.delete(
        Uri.parse(
          '${Constants.PRODUCT_BASE_URL}/${product.id}.json?auth=$_token',
        ),
      );

      if (response.statusCode >= 400) {
        _items.insert(index, product);
        notifyListeners();
        throw HttpException(
          msg: 'Não foi possível excluir o produto.',
          statusCode: response.statusCode,
        );
      }
    }
  }

  static Future<List<Game>> getGames(String query) async {
    final url = Uri.parse('${Constants.PRODUCT_BASE_URL}.json');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List games = json.decode(response.body);

      return games.map((json) => Game.fromJson(json)).where((game) {
        final nameLower = game.name.toLowerCase();
        final searchLower = query.toLowerCase();

        return nameLower.contains(searchLower);
      }).toList();
    } else {
      throw Exception();
    }
  }
}
