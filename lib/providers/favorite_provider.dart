import 'package:flutter/material.dart';

class FavoritesProvider extends ChangeNotifier {
  final List<Map> _favorites = [];

  List<Map> get favorites => _favorites;

  void addFavorite(Map meal) {
    if (!_favorites.contains(meal)) {
      _favorites.add(meal);
      notifyListeners();
    }
  }

  void removeFavorite(Map meal) {
    _favorites.remove(meal);
    notifyListeners();
  }

  bool isFavorite(Map meal) {
    return _favorites.contains(meal);
  }
}
