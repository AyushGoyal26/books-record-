import 'package:booksrecord/features/books/domain/entities/book.dart';
import 'package:booksrecord/features/books/domain/repositories/book_repository.dart';
import 'package:booksrecord/features/books/data/sources/book_api_service.dart';
import 'package:booksrecord/features/books/data/models/book_model.dart';

class BookRepositoryImpl implements BookRepository {
  final BookApiService apiService;

  BookRepositoryImpl(this.apiService);

  @override
  Future<List<Book>> fetchBooks() async {
    return await apiService.fetchBooks();
  }

  @override
  Future<Book> addBook(Book book) async {
    final model = BookModel(
      id: '',
      title: book.title,
      authors: book.authors,
      coverImage: book.coverImage,
    );
    return await apiService.addBook(model);
  }

  @override
  Future<Book> updateBook(Book book) async {
    final model = BookModel(
      id: book.id,
      title: book.title,
      authors: book.authors,
      coverImage: book.coverImage,
    );
    return await apiService.updateBook(model);
  }

  @override
  Future<void> deleteBook(String id) async {
    await apiService.deleteBook(id);
  }
}
