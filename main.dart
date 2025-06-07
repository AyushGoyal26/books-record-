import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:booksrecord/features/books/data/sources/book_api_service.dart';
import 'package:booksrecord/features/books/domain/repositories/book_repository_impl.dart';
import 'package:booksrecord/features/books/domain/repositories/book_repository.dart';
import 'package:booksrecord/features/books/presentation/bloc/book_bloc.dart';
import 'package:booksrecord/features/books/presentation/screens/books_list_screen.dart';
import 'package:booksrecord/features/books/presentation/bloc/book_event.dart';

void main() {
  final dio = Dio();
  final apiService = BookApiService(dio);
  final BookRepository repository = BookRepositoryImpl(apiService);

  runApp(BookApp(repository: repository));
}

class BookApp extends StatelessWidget {
  final BookRepository repository;
  const BookApp({Key? key, required this.repository}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<BookRepository>.value(value: repository),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<BookBloc>(
            create: (context) => BookBloc(repository)..add(FetchBooksEvent()),
          ),
        ],
        child: MaterialApp(
          title: 'Book Records',
          theme: ThemeData(primarySwatch: Colors.blue),
          home: const BookListScreen(),
        ),
      ),
    );
  }
}
