import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/article_provider.dart';
import 'providers/favori_provider.dart';
import 'providers/commentaire_provider.dart';
import 'screens/home_screen.dart';
import 'screens/news_sport_screen.dart';
import 'screens/news_sante_screen.dart';
import 'screens/news_education_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ArticleProvider()),
        ChangeNotifierProvider(create: (_) => FavoriProvider()),
        ChangeNotifierProvider(create: (_) => CommentaireProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter News',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
        fontFamily: 'Roboto',
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
        ),
      ),
      home: const HomeScreen(),
      debugShowCheckedModeBanner: false,
      routes: {
        '/news_sport': (context) => const NewsSportScreen(),
        '/news_sante': (context) => const NewsSanteScreen(),
        '/news_education': (context) => const NewsEducationScreen(),
      },
    );
  }
}
