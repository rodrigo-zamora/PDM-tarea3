// ignore_for_file: non_constant_identifier_names, avoid_print, unused_local_variable, prefer_const_constructors, prefer_typing_uninitialized_variables

import 'dart:async';
import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'package:http/http.dart' as http;

part 'book_event.dart';
part 'book_state.dart';

class BookBloc extends Bloc<BookEvent, BookState> {
  BookBloc() : super(BookInitial()) {
    on<BookEvent>(_searchBook);
  }

  final BOOK_ENDPOINT = "https://www.googleapis.com/books/v1/volumes?q=";

  FutureOr<void> _searchBook(event, emit) async {
    print("Searching book using API endpoint: $BOOK_ENDPOINT");
    emit(BookLoading());

    print("\tSending request to API...");
    try {
      final uri = Uri.parse(BOOK_ENDPOINT + event.query);
      var response = await http.get(uri);
      final res = jsonDecode(response.body);

      if (res["totalItems"] == 0) {
        emit(BookError(message: "No se encontraron resultados"));
        return;
      }

      var books = [];
      for (var book in res["items"]) {
        var image;
        try {
          image = book["volumeInfo"]["imageLinks"]["thumbnail"];
        } catch (e) {
          image =
              "https://www.thebookdesigner.com/wp-content/uploads/2018/04/type-color-filosofia-12on16-6x9-96.jpg";
        }

        var description;
        try {
          description = book["volumeInfo"]["description"];
        } catch (e) {
          description = null;
        }

        books.add({
          "title": book["volumeInfo"]["title"],
          "image": image,
          "date": book["volumeInfo"]["publishedDate"],
          "description": description ?? "No hay descripción disponible",
          "pageCount": book["volumeInfo"]["pageCount"],
        });
      }

      print("\tResponse received from API: ${res['items']}");
      emit(BookLoaded(books: books));
    } catch (error) {
      emit(BookError(message: "Ha ocurrido un error: $error"));
    }
  }
}
