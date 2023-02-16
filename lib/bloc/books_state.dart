// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'books_bloc.dart';

enum BooksStateStatus {
  initial,
  loading,
  loadedSuccess,
  loadedError,
}

class BooksState {
  final BooksStateStatus? status;
  final List<BooksModel>? books;
  final int? quantity;

  BooksState({
    this.status,
    this.books,
    this.quantity,
  });

  BooksState copyWith({
    BooksStateStatus? status,
    List<BooksModel>? books,
    int? quantity,
  }) {
    return BooksState(
      status: status ?? this.status,
      books: books ?? this.books,
      quantity: quantity ?? this.quantity,
    );
  }
}

// abstract class BooksState extends Equatable {}

// class BooksLoadingState extends BooksState {
//   @override
//   List<Object?> get props => [];
// }

// class BooksLoadedState extends BooksState {
//   @override
//   List<Object?> get props => [];
// }
