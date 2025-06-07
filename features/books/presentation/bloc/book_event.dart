import 'package:equatable/equatable.dart';
import 'package:booksrecord/features/books/domain/entities/book.dart';

abstract class BookEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchBooksEvent extends BookEvent {}

class AddBookEvent extends BookEvent {
  final Book book;
  AddBookEvent(this.book);

  @override
  List<Object?> get props => [book];
}

class UpdateBookEvent extends BookEvent {
  final Book book;
  UpdateBookEvent(this.book);

  @override
  List<Object?> get props => [book];
}

class DeleteBookEvent extends BookEvent {
  final String id;
  DeleteBookEvent(this.id);

  @override
  List<Object?> get props => [id];
}
