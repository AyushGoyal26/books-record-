import 'package:dio/dio.dart';
import 'package:booksrecord/features/books/data/models/book_model.dart';

class BookApiService {
  final Dio dio;
  final String baseUrl = 'https://readbuddy-server.onrender.com/api/books'; // use HTTPS

  BookApiService(this.dio);

  Future<List<BookModel>> fetchBooks() async {
    final response = await dio.get(baseUrl);
    final data = response.data as List;
    return data.map((json) => BookModel.fromJson(json)).toList();
  }

  Future<BookModel> addBook(BookModel book) async {
    try {
      final response = await dio.post(
        baseUrl,
        data: book.toJson(),
        // Token is already added in Dio instance; no need to add it again here
      );
      return BookModel.fromJson(response.data);
    } catch (e) {
      print('Error adding book: $e');
      rethrow;
    }
  }

  Future<BookModel> updateBook(BookModel book) async {
    final response = await dio.put('$baseUrl/${book.id}', data: book.toJson());
    return BookModel.fromJson(response.data);
  }

  Future<void> deleteBook(String id) async {
    await dio.delete('$baseUrl/$id');
  }
}
