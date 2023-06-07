import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gosheno/app/data/models/book_model.dart';
import 'package:gosheno/app/data/provider/book_api_provider.dart';
import 'package:gosheno/app/data/repository/book_repository.dart';

class SearchController extends GetxController {
  final BookRepository _bookRepository = BookRepository(
    bookApiClient: BookApiClient(),
  );
  TextEditingController searchController = TextEditingController();
  Timer? _debounce;
  List<Book> books = [];

  @override
  onClose() {
    super.onClose();
    searchController.dispose();
    _debounce?.cancel();
  }

  void search(String search) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(seconds: 1), () async {
      var response = await _bookRepository.searchBook(search: search);
      if (response['status']) {
        books = response['books'];
        update();
      } //
      else {
        books = [];
        update();
      }
    });
  }

  bool popSearch() {
    books = [];
    searchController.clear();
    update();
    return true;
  }
}
