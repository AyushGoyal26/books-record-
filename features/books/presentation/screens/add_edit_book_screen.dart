import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:booksrecord/features/books/domain/entities/book.dart';
import 'package:booksrecord/features/books/presentation/bloc/book_bloc.dart';
import 'package:booksrecord/features/books/presentation/bloc/book_event.dart';

class AddEditBookScreen extends StatefulWidget {
  final Book? book;
  const AddEditBookScreen({Key? key, this.book}) : super(key: key);

  @override
  State<AddEditBookScreen> createState() => _AddEditBookScreenState();
}

class _AddEditBookScreenState extends State<AddEditBookScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _authorsController;
  late TextEditingController _coverImageController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.book?.title ?? '');
    _authorsController =
        TextEditingController(text: widget.book?.authors.join(', ') ?? '');
    _coverImageController =
        TextEditingController(text: widget.book?.coverImage ?? '');
  }

  @override
  void dispose() {
    _titleController.dispose();
    _authorsController.dispose();
    _coverImageController.dispose();
    super.dispose();
  }

  void _save() {
    if (_formKey.currentState!.validate()) {
      final bookBloc = context.read<BookBloc>();
      final authorsList =
          _authorsController.text.split(',').map((e) => e.trim()).toList();

      final book = Book(
        id: widget.book?.id ?? '', // id empty for add, else edit
        title: _titleController.text.trim(),
        authors: authorsList,
        coverImage: _coverImageController.text.trim().isEmpty
            ? null
            : _coverImageController.text.trim(),
      );

      if (widget.book == null) {
        bookBloc.add(AddBookEvent(book));
      } else {
        bookBloc.add(UpdateBookEvent(book));
      }

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.book != null;
    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Edit Book' : 'Add Book'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Title'),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Enter title' : null,
              ),
              TextFormField(
                controller: _authorsController,
                decoration:
                    const InputDecoration(labelText: 'Authors (comma separated)'),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Enter authors' : null,
              ),
              TextFormField(
                controller: _coverImageController,
                decoration: const InputDecoration(
                    labelText: 'Cover Image URL (optional)'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _save,
                child: Text(isEditing ? 'Update' : 'Add'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
