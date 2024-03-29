
import 'dart:io';

import 'package:escribo_desafio_2/data/local/book_database_repository.dart';
import 'package:escribo_desafio_2/domain/models/book_model.dart';
import 'package:escribo_desafio_2/domain/models/book_service_interface.dart';

import 'book_service.dart';

class BookServiceRepository implements BookServiceInterface {
  BookServiceRepository({required this.bookService, required this.bookDatabaseRepository});

  final BookService bookService;
  final BookDatabaseRepository bookDatabaseRepository;

  @override
  Future<List<BookModel>> getBooks() async {
    return bookService.getBooks();
  }

  @override
  Future<String> downloadBook(String url, int bookId) async {
    String? localPath = await bookDatabaseRepository.getLocalPath(bookId);

    if (localPath != null && await File(localPath).exists()) {
      return localPath;
    } else{
      String downloadedPath = await bookService.downloadBook(url, bookId);
      await bookDatabaseRepository.saveBookPath(bookId, downloadedPath);
      return downloadedPath;
    }
  }
}