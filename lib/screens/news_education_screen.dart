import 'package:flutter/material.dart';

class NewsEducationScreen extends StatelessWidget {
  const NewsEducationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('News Education')),
      body: const Center(child: Text('Articles éducatifs à afficher ici.')),
    );
  }
}
