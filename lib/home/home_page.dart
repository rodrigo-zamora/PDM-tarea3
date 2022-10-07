// ignore_for_file: prefer_const_constructors, must_be_immutable, unused_field, non_constant_identifier_names, unused_element, avoid_print, unused_local_variable

import 'package:book_repository/home/book_bloc/book_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:shimmer/shimmer.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Librería free to play'),
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Ingresa un título',
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    BlocProvider.of<BookBloc>(context)
                        .add(SearchBook(query: _searchController.text));

                    // Hide keyboard
                    FocusScope.of(context).unfocus();
                  },
                ),
              ),
              controller: _searchController,
            ),
          ),
          _buildBookList(),
        ],
      ),
    );
  }

  BlocConsumer<BookBloc, BookState> _buildBookList() {
    return BlocConsumer<BookBloc, BookState>(
      listener: (context, BookState state) {},
      builder: (context, state) {
        switch (state.runtimeType) {
          case BookInitial:
            return Expanded(
              child: Center(
                child: Text('Ingresa un título para buscar'),
              ),
            );
          case BookLoading:
            return Expanded(
              child: SizedBox(
                  child: Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: GridView.count(
                        crossAxisCount: 2,
                        children: List.generate(6, (index) {
                          return Container(
                            padding: EdgeInsets.all(10),
                            margin: EdgeInsets.all(10),
                            child: Column(
                              children: [
                                Expanded(
                                  child: Container(
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  height: 10,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                          );
                        }),
                      ))),
            );
          case BookLoaded:
            final books = (state as BookLoaded).books;
            return Expanded(
              child: GridView.count(
                padding: EdgeInsets.all(10),
                crossAxisCount: 2,
                children: List.generate(books.length, (index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/book_details',
                          arguments: books[index]);
                    },
                    child: Container(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        children: [
                          Expanded(
                            child: Image.network(books[index]['image']),
                          ),
                          Text(books[index]['title']),
                        ],
                      ),
                    ),
                  );
                }),
              ),
            );
          default:
            final message = (state as BookError).message;
            return Expanded(
              child: Center(
                child: Text(message),
              ),
            );
        }
      },
    );
  }
}
