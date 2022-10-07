// ignore_for_file: prefer_const_constructors, unused_local_variable, avoid_print
import 'package:flutter/material.dart';

import 'package:share_plus/share_plus.dart';

class BookDetails extends StatefulWidget {
  const BookDetails({super.key});

  @override
  State<BookDetails> createState() => _BookDetailsState();
}

class _BookDetailsState extends State<BookDetails> {
  bool fullDescription = false;

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments;
    args as Map<String, dynamic>;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalles del libro'),
        actions: [
          IconButton(
            icon: Icon(Icons.public),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () async {
              await Share.share(
                'Título: ${args['title']}\nNúmero de páginas: ${args['pageCount']}',
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.all(10),
                child: SizedBox(
                  width: 200,
                  height: 200,
                  child: Image.network(
                    args['image'],
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: Text(
                  args['title'],
                  style: TextStyle(
                    fontSize: 20,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Container(
                padding: EdgeInsets.only(left: 10, top: 20),
                child: Text(
                  args['date'],
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Container(
                padding: EdgeInsets.only(left: 10),
                child: Text(
                  'Páginas: ${args['pageCount']}',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.only(left: 10, top: 6),
            alignment: Alignment.centerLeft,
            child: GestureDetector(
              onTap: () {
                fullDescription = !fullDescription;
                setState(() {});
              },
              child: _getDescription(args['description'], fullDescription),
            ),
          ),
        ],
      ),
    );
  }

  Widget _getDescription(String description, bool fullDescription) {
    if (fullDescription) {
      return Text(
        description,
        style: TextStyle(
          fontSize: 14,
          fontStyle: FontStyle.italic,
        ),
      );
    } else {
      if (description.length > 250) {
        return Text(
          '${description.substring(0, 250)}...',
          style: TextStyle(
            fontSize: 14,
            fontStyle: FontStyle.italic,
          ),
        );
      } else {
        return Text(
          description,
          style: TextStyle(
            fontSize: 14,
            fontStyle: FontStyle.italic,
          ),
        );
      }
    }
  }
}
