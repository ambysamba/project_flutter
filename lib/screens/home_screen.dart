import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/article_provider.dart';
import '../models/article.dart';
import 'detail_screen.dart';
import 'favoris_screen.dart';
import 'package:flutter/services.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final articleProvider = Provider.of<ArticleProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Actualités'),
        actions: [
          IconButton(
            icon: const Icon(Icons.menu),
            tooltip: 'Menu',
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (context) => Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ListTile(
                      leading: const Icon(Icons.sports_soccer),
                      title: const Text('News Sport'),
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.pushNamed(context, '/news_sport');
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.health_and_safety),
                      title: const Text('News Santé'),
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.pushNamed(context, '/news_sante');
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.school),
                      title: const Text('News Education'),
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.pushNamed(context, '/news_education');
                      },
                    ),
                  ],
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.refresh),
            tooltip: 'Recharger',
            onPressed: () => articleProvider.loadArticles(),
          ),
          IconButton(
            icon: const Icon(Icons.favorite),
            tooltip: 'Favoris',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const FavorisScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: Builder(
        builder: (context) {
          if (articleProvider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (articleProvider.error != null) {
            return Center(child: Text('Erreur: ${articleProvider.error!}'));
          }
          if (articleProvider.articles.isEmpty) {
            return const Center(
              child: Text(
                'Aucun article disponible. Vérifiez votre connexion ou la clé API.',
                style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
                textAlign: TextAlign.center,
              ),
            );
          }
          return RefreshIndicator(
            onRefresh: () => articleProvider.loadArticles(),
            child: ListView.builder(
              itemCount: articleProvider.articles.length,
              itemBuilder: (context, index) {
                Article article = articleProvider.articles[index];
                return ListTile(
                  leading: article.imageUrl.isNotEmpty
                      ? Image.network(article.imageUrl,
                          width: 60, fit: BoxFit.cover)
                      : null,
                  title: Text(article.title),
                  subtitle: Text(article.description),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => DetailScreen(article: article),
                      ),
                    );
                  },
                );
              },
            ),
          );
        },
      ),
      // Pas de bouton de sortie sur la page d'accueil
    );
  }
}
