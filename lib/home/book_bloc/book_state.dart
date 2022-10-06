// ignore_for_file: override_on_non_overriding_member, prefer_const_constructors_in_immutables

part of 'book_bloc.dart';

@immutable
abstract class BookState {
  const BookState();

  @override
  String get props => '';
}

class BookInitial extends BookState {}

class BookLoading extends BookState {}

class BookLoaded extends BookState {
  final List<dynamic> books;

  BookLoaded({required this.books});
}

class BookError extends BookState {
  final String message;

  BookError({required this.message});
}
