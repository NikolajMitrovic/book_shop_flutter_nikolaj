// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'books_bloc.dart';

abstract class BooksEvent {}

class LoadBooksEvent extends BooksEvent {
  int? quantity;
  LoadBooksEvent({
    this.quantity,
  });
}
