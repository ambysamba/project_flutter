import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:project_flutter/models/comment.dart';
import '../models/article.dart';

class ApiService {
  static const String baseUrl = "https://hacker-news.firebaseio.com/v0";

  Future<Article> fetchArticle(int id) async {
    final response =
        await http.get(Uri.parse('$baseUrl/item/$id.json?print=pretty'));
    if (response.statusCode == 200) {
      return Article.fromJson(json.decode(response.body));
    } else {
      throw Exception('Échec du chargement de l’article');
    }
  }

  Future<List<int>> fetchTopStories() async {
    final response =
        await http.get(Uri.parse('$baseUrl/topstories.json?print=pretty'));
    if (response.statusCode == 200) {
      return List<int>.from(json.decode(response.body));
    } else {
      throw Exception('Échec du chargement des top stories');
    }
  }

  Future<Comment> fetchComment(int id) async {
    final response =
        await http.get(Uri.parse('$baseUrl/item/$id.json?print=pretty'));
    if (response.statusCode == 200) {
      return Comment.fromJson(json.decode(response.body));
    } else {
      throw Exception('Erreur chargement commentaire');
    }
  }
}
