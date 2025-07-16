import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';
// If you are using webview_flutter version 4.0.0 or above, you need to use WebViewWidget and create a WebViewController.
import '../models/article.dart';
import '../providers/favori_provider.dart';
import '../providers/commentaire_provider.dart';
import '../models/comment.dart';
import 'package:flutter/services.dart';

class DetailScreen extends StatelessWidget {
  final Article article;
  const DetailScreen({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    final favoriProvider = Provider.of<FavoriProvider>(context);
    final commentaireProvider = Provider.of<CommentaireProvider>(context);
    final isFavori = favoriProvider.estFavori(article.id);
    final commentaires =
        commentaireProvider.getCommentaires(int.tryParse(article.id) ?? 0);

    return Scaffold(
      appBar: AppBar(
        title: Text(article.title),
        actions: [
          IconButton(
            icon: Icon(isFavori ? Icons.favorite : Icons.favorite_border,
                color: Colors.red),
            onPressed: () {
              if (isFavori) {
                favoriProvider.retirerFavori(article.id);
              } else {
                favoriProvider.ajouterFavori(article.id);
              }
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (article.imageUrl.isNotEmpty)
              Image.network(article.imageUrl,
                  width: double.infinity, height: 200, fit: BoxFit.cover),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(article.description,
                  style: const TextStyle(fontSize: 16)),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Commentaires',
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  IconButton(
                    icon: const Icon(Icons.add_comment),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          final controller = TextEditingController();
                          return AlertDialog(
                            title: const Text('Ajouter un commentaire'),
                            content: TextField(
                              controller: controller,
                              decoration: const InputDecoration(
                                  hintText: 'Votre commentaire'),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  commentaireProvider.ajouterCommentaire(
                                    int.tryParse(article.id) ?? 0,
                                    Comment(
                                      id: DateTime.now().millisecondsSinceEpoch,
                                      text: controller.text,
                                      by: 'Utilisateur',
                                      time:
                                          DateTime.now().millisecondsSinceEpoch,
                                      kids: [],
                                    ),
                                  );
                                  Navigator.pop(context);
                                },
                                child: const Text('Envoyer'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
            ...commentaires.map((c) => ListTile(
                  leading: const Icon(Icons.comment),
                  title: Text(c.by ?? 'Utilisateur'),
                  subtitle: Text(c.text ?? ''),
                  trailing: c.time != null
                      ? Text(DateTime.fromMillisecondsSinceEpoch(c.time!)
                          .toString()
                          .substring(0, 10))
                      : null,
                )),
            if (commentaires.isEmpty)
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text('Aucun commentaire pour cet article.'),
              ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton.icon(
                icon: const Icon(Icons.open_in_browser),
                label: const Text('Lire l’article complet'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => WebViewScreen(url: article.url),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          SystemNavigator.pop();
        },
        child: const Icon(Icons.exit_to_app),
        tooltip: 'Quitter',
      ),
    );
  }
}

class WebViewScreen extends StatelessWidget {
  final String url;
  const WebViewScreen({super.key, required this.url});
  @override
  Widget build(BuildContext context) {
    final controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(url));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Article'),
      ),
      body: WebViewWidget(controller: controller),
    );
  }
}
