import 'package:flutter/material.dart';
import '../models/comment.dart';

class CommentaireProvider extends ChangeNotifier {
  final Map<int, List<Comment>> _commentsByArticle = {};

  List<Comment> getCommentaires(int articleId) {
    return _commentsByArticle[articleId] ?? [];
  }

  void setCommentaires(int articleId, List<Comment> comments) {
    _commentsByArticle[articleId] = comments;
    notifyListeners();
  }

  void ajouterCommentaire(int articleId, Comment comment) {
    if (_commentsByArticle[articleId] == null) {
      _commentsByArticle[articleId] = [];
    }
    _commentsByArticle[articleId]!.add(comment);
    notifyListeners();
  }
}
