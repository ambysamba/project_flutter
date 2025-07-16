import 'package:flutter/material.dart';
import '../models/article.dart';
import '../services/news_service.dart';
import '../services/database_service.dart';

class ArticleProvider extends ChangeNotifier {
  Future<void> cleanLocalArticles(List<String> favorisIds) async {
    // Récupère tous les articles locaux
    final db = DatabaseService();
    final localIds = await db.getAllArticleIds();
    // Charge les articles API (pour obtenir les ids valides)
    List<String> apiIds = [];
    try {
      final apiArticles = await NewsService().fetchArticles();
      apiIds = apiArticles.map((a) => a.id).toList();
    } catch (_) {}
    // Supprime les articles locaux qui ne sont ni dans l’API ni dans les favoris
    for (final id in localIds) {
      if (!apiIds.contains(id) && !favorisIds.contains(id)) {
        await db.deleteArticleById(id);
      }
    }
  }

  List<Article> _articles = [];
  bool _isLoading = false;
  String? _error;

  List<Article> get articles => _articles;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> loadArticles() async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    try {
      _articles = await NewsService().fetchArticles();
    } catch (e) {
      _error = e.toString();
    }
    _isLoading = false;
    notifyListeners();
  }

  ArticleProvider() {
    loadArticles();
  }
}
