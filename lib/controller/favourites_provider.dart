import 'package:flutter/material.dart';

class FavoritesProvider extends ChangeNotifier {
  List<Map<String, dynamic>> _favoriteProducts = [];

  List<Map<String, dynamic>> get favoriteProducts => _favoriteProducts;

  void toggleFavorite(Map<String, dynamic> product) {
    if (_favoriteProducts.contains(product)) {
      _favoriteProducts.remove(product);
    } else {
      _favoriteProducts.add(product);
    }
    notifyListeners();
  }

  void removeFavorite(int index) {
    _favoriteProducts.removeAt(index);
    notifyListeners();
  }
}
