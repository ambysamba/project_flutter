import 'package:flutter/material.dart';

class NewsSanteScreen extends StatelessWidget {
  const NewsSanteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('News Santé')),
      body: const Center(child: Text('Articles de santé à afficher ici.')),
    );
  }
}
