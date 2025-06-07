import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:booksrecord/features/books/presentation/bloc/book_event.dart';
import 'package:booksrecord/features/books/presentation/bloc/book_state.dart';
import 'package:booksrecord/features/books/domain/repositories/book_repository.dart';
import 'package:booksrecord/features/books/domain/entities/book.dart';

class BookBloc extends Bloc<BookEvent, BookState> {
  final BookRepository repository;

  BookBloc(this.repository) : super(BookInitial()) {
    on<FetchBooksEvent>((event, emit) async {
      emit(BookLoading());
      try {
        final books = await repository.fetchBooks();
        emit(BookLoaded(books));
      } catch (e) {
        emit(BookError('Failed to fetch books'));

      }
    });

    on<AddBookEvent>((event, emit) async {
      try {
        await repository.addBook(event.book);
        final books = await repository.fetchBooks();
        emit(BookLoaded(books));
      } catch (e) {
        emit(BookError('Failed to add book'));
      }
    });

    on<UpdateBookEvent>((event, emit) async {
      try {
        await repository.updateBook(event.book);
        final books = await repository.fetchBooks();
        emit(BookLoaded(books));
      } catch (e) {
        emit(BookError('Failed to update book'));
      }
    });

    on<DeleteBookEvent>((event, emit) async {
      try {
        await repository.deleteBook(event.id);
        final books = await repository.fetchBooks();
        emit(BookLoaded(books));
      } catch (e) {
        emit(BookError('Failed to delete book'));
      }
    });
  }
}
