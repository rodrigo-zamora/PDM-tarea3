import 'package:flutter/material.dart';

class BookDetails extends StatelessWidget {
  const BookDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalles del libro'),
      ),
      body: const Center(
        child: Text('Hello World'),
      ),
    );
  }
}
