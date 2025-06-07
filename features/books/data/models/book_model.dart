import 'package:booksrecord/features/books/domain/entities/book.dart';

class BookModel extends Book {
  BookModel({
    required String id,
    required String title,
    required List<String> authors,
    String? coverImage,
  }) : super(id: id, title: title, authors: authors, coverImage: coverImage);

  factory BookModel.fromJson(Map<String, dynamic> json) {
    return BookModel(
      id: json['_id'] ?? '', // match API _id
      title: json['title'] ?? '',
      authors: List<String>.from(json['authors'] ?? []),
      coverImage: json['coverImageUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'authors': authors,
      'coverImage': coverImage,
    };
  }
}
