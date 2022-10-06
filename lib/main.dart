// ignore_for_file: prefer_const_constructors

import 'package:book_repository/home/book_bloc/book_bloc.dart';
import 'package:book_repository/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'home/book_details.dart';

void main() => runApp(BlocProvider(
      create: (context) => BookBloc(),
      child: const MyApp(),
    ));

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: Color.fromARGB(255, 51, 51, 51),
        ),
      ),
      home: HomePage(),
      routes: {
        '/book_details': (context) => const BookDetails(),
      },
    );
  }
}
