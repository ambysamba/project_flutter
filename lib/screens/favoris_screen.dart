import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/favori_provider.dart';
import '../models/article.dart';
import '../providers/article_provider.dart';
import 'detail_screen.dart'; // Assurez-vous d'importer votre écran de détail

class FavorisScreen extends StatelessWidget {
  const FavorisScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final favoriProvider = Provider.of<FavoriProvider>(context);
    final articleProvider = Provider.of<ArticleProvider>(context);
    final favoris = favoriProvider.favoris;
    final articles = articleProvider.articles;
    return Scaffold(
      appBar: AppBar(title: const Text('Mes Favoris')),
      body: favoris.isEmpty
          ? const Center(child: Text('Aucun favori pour le moment.'))
          : ListView.builder(
              itemCount: favoris.length,
              itemBuilder: (context, index) {
                final favori = favoris[index];
                final article = articles.firstWhere(
                  (a) => a.id == favori.articleId,
                  orElse: () => Article(
                    id: '',
                    title: 'Article supprimé',
                    description: '',
                    url: '',
                    imageUrl: '',
                    publishedAt: '',
                  ),
                );
                return ListTile(
                  leading: article.imageUrl.isNotEmpty
                      ? Image.network(article.imageUrl,
                          width: 60, fit: BoxFit.cover)
                      : null,
                  title: Text(article.title),
                  subtitle: Text(article.description),
                  onTap: article.id.isNotEmpty
                      ? () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => DetailScreen(article: article),
                            ),
                          );
                        }
                      : null,
                );
              },
            ),
    );
  }
}
