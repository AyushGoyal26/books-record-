class Book {
  final String id;
  final String title;
  final List<String> authors;
  final String? coverImage;

  Book({
    required this.id,
    required this.title,
    required this.authors,
    this.coverImage,
  });
}
