import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/article.dart';

class NewsService {
  final String apiKey =
      '8e6d7a64079145df8f1bef4b62a516d4'; // Remplacez par votre clé API
  final String baseUrl =
      'https://newsapi.org/v2/top-headlines?country=us&pageSize=20';

  Future<List<Article>> fetchArticles() async {
    final response = await http.get(Uri.parse('$baseUrl&apiKey=$apiKey'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List articles = data['articles'];
      print('Articles reçus:');
      print(articles);
      return articles.map((json) => Article.fromJson(json)).toList();
    } else {
      print('Erreur API: ${response.body}');
      throw Exception('Erreur lors du chargement des articles');
    }
  }
}
