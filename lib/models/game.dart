import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:projeto_nerdlandia/utils/constants.dart';

class Game with ChangeNotifier {
  final String id;
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  final String platformType;
  final String ageRestriction;
  final String gender;
  bool isFavorite;

  Game({
    @required this.id,
    @required this.name,
    @required this.description,
    @required this.price,
    @required this.imageUrl,
    @required this.platformType,
    @required this.ageRestriction,
    @required this.gender,
    this.isFavorite = false,
  });

  void _toggleFavorite() {
    isFavorite = !isFavorite;
    notifyListeners();
  }

  Future<void> toggleFavorite(String token, String userId) async {
    try {
      _toggleFavorite();

      final response = await http.put(
        Uri.parse(
          '${Constants.USER_FAVORITES_URL}/$userId/$id.json?auth=$token',
        ),
        body: jsonEncode(isFavorite),
      );

      if (response.statusCode >= 400) {
        _toggleFavorite();
      }
    } catch (_) {
      _toggleFavorite();
    }
  }

  factory Game.fromJson(Map<String, dynamic> json) => Game(
        id: json['id'],
        name: json['name'],
        description: json['description'],
        price: json['price'],
        imageUrl: json['imageUrl'],
        platformType: json['platformType'],
        ageRestriction: json['ageRestriction'],
        gender: json['gender'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'description': description,
        'price': price,
        'imageUrl': imageUrl,
        'platformType': platformType,
        'ageRestriction': ageRestriction,
        'gender': gender,
      };

  String get completeGameName {
    String completeName = name + " " + platformType;
    return completeName;
  }
}
