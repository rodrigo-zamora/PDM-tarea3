// ignore_for_file: prefer_const_constructors_in_immutables, override_on_non_overriding_member

part of 'book_bloc.dart';

@immutable
abstract class BookEvent {
  const BookEvent();

  @override
  String get props => '';
}

class SearchBook extends BookEvent {
  final String query;

  SearchBook({required this.query});
}
