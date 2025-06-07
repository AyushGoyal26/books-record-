import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:booksrecord/features/books/presentation/bloc/book_bloc.dart';
import 'package:booksrecord/features/books/presentation/bloc/book_event.dart';
import 'package:booksrecord/features/books/presentation/bloc/book_state.dart';
import 'package:booksrecord/features/books/domain/entities/book.dart';
import 'package:booksrecord/features/books/presentation/screens/add_edit_book_screen.dart';

class BookListScreen extends StatelessWidget {
  const BookListScreen({Key? key}) : super(key: key);

  void _navigateToAdd(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const AddEditBookScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bookBloc = context.read<BookBloc>();

    return Scaffold(
      appBar: AppBar(title: const Text('Books List')),
      body: BlocBuilder<BookBloc, BookState>(
        builder: (context, state) {
          if (state is BookLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is BookLoaded) {
            final books = state.books;
            if (books.isEmpty) {
              return const Center(child: Text('No books available'));
            }
            return ListView.builder(
              itemCount: books.length,
              itemBuilder: (context, index) {
                final book = books[index];
                return ListTile(
                  leading:
                      book.coverImage != null
                          ? Image.network(
                            book.coverImage!,
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                            errorBuilder: (
                              BuildContext context,
                              Object error,
                              StackTrace? stackTrace,
                            ) {
                              return Icon(Icons.book);
                            },
                          )
                          : const Icon(Icons.book),
                  title: Text(book.title),
                  subtitle: Text(book.authors.join(', ')),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => AddEditBookScreen(book: book),
                            ),
                          );
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          bookBloc.add(DeleteBookEvent(book.id));
                        },
                      ),
                    ],
                  ),
                );
              },
            );
          } else if (state is BookError) {
            return Center(child: Text('Error: ${state.message}'));
          }
          return const SizedBox.shrink();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _navigateToAdd(context),
        child: const Icon(Icons.add),
      ),
    );
  }
}
