class Article {
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'url': url,
      'imageUrl': imageUrl,
      'publishedAt': publishedAt,
    };
  }

  final String id;
  final String title;
  final String description;
  final String url;
  final String imageUrl;
  final String publishedAt;

  Article({
    required this.id,
    required this.title,
    required this.description,
    required this.url,
    required this.imageUrl,
    required this.publishedAt,
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    // Utilise l'id numérique si disponible, sinon fallback sur url
    final idValue = json['id']?.toString() ?? json['url'] ?? '';
    return Article(
      id: idValue,
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      url: json['url'] ?? '',
      imageUrl: json['urlToImage'] ?? '',
      publishedAt: json['publishedAt'] ?? '',
    );
  }
}
