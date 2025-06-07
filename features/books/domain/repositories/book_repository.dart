import 'package:booksrecord/features/books/domain/entities/book.dart';

abstract class BookRepository {
  Future<List<Book>> fetchBooks();
  Future<Book> addBook(Book book);
  Future<Book> updateBook(Book book);
  Future<void> deleteBook(String id);
}
