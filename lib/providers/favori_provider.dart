import 'package:flutter/material.dart';
import '../models/favori.dart';
import '../services/database_service.dart';

class FavoriProvider extends ChangeNotifier {
  final List<Favori> _favoris = [];

  List<Favori> get favoris => _favoris;

  FavoriProvider() {
    _loadFavoris();
  }

  Future<void> _loadFavoris() async {
    final ids = await DatabaseService().getFavoris();
    _favoris.clear();
    _favoris.addAll(ids.map((id) => Favori(articleId: id)));
    notifyListeners();
  }

  Future<void> ajouterFavori(String articleId) async {
    if (!_favoris.any((f) => f.articleId == articleId)) {
      await DatabaseService().insertFavori(articleId);
      _favoris.add(Favori(articleId: articleId));
      notifyListeners();
    }
  }

  Future<void> retirerFavori(String articleId) async {
    await DatabaseService().deleteFavori(articleId);
    _favoris.removeWhere((f) => f.articleId == articleId);
    notifyListeners();
  }

  bool estFavori(String articleId) {
    return _favoris.any((f) => f.articleId == articleId);
  }
}
