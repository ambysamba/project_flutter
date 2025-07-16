import 'package:flutter/material.dart';

class NewsSportScreen extends StatelessWidget {
  const NewsSportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('News Sport')),
      body: const Center(child: Text('Articles de sport à afficher ici.')),
    );
  }
}
