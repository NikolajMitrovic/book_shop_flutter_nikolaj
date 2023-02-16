import 'dart:async';

import 'package:book_shop_flutter/models/book_model.dart';
import 'package:book_shop_flutter/repositories/repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'books_event.dart';
part 'books_state.dart';

class BooksBloc extends Bloc<BooksEvent, BooksState> {
  final BooksRepository booksRepository;
  BooksBloc(this.booksRepository) : super(initialState()) {
    on<LoadBooksEvent>(_loadBooks);
  }

  static BooksState initialState() {
    return BooksState(
      status: BooksStateStatus.initial,
      books: [],
      quantity: 10,
    );
  }

  Future<void> _loadBooks(LoadBooksEvent event, Emitter<BooksState> emit) async {
    emit(
      state.copyWith(
        status: BooksStateStatus.loading,
        quantity: event.quantity,
      ),
    );
    final result = await booksRepository.getBooks(quantity: event.quantity);
    if (result != null) {
      emit(state.copyWith(
        status: BooksStateStatus.loadedSuccess,
        books: result,
      ));
    } else {
      emit(state.copyWith(status: BooksStateStatus.loadedError));
    }
  }
}
