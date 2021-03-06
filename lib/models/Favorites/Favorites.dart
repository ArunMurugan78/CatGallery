import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';

class Favorites with ChangeNotifier {
  final LocalStorage storage = new LocalStorage('data.json');

  List<String> _favorites = [];
  Set _s = new Set();

  bool isFavorite(String url) => _s.contains(url);

  List<String> get favorites => _favorites;

  init() async {
    await storage.ready;
    _favorites = (storage.getItem('favorites') ?? []).cast<String>().toList();
    _s.addAll(_favorites);
  }

  Favorites() {
    init();
  }
  _saveToStorage() {
    storage.setItem('favorites', _favorites);
  }

  void removeFromFavorites(String url) {
    if (_s.contains(url)) {
      _favorites.remove(url);
      _s.remove(url);
      _saveToStorage();
      notifyListeners();
    }
  }

  void addToFavorites(String url) {
    if (!_s.contains(url)) {
      _favorites.insert(0, url);
      _s.add(url);
      _saveToStorage();
      notifyListeners();
    }
  }
}
