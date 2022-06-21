import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gosheno/app/data/repository/book_repository.dart';

import '../../data/models/comment_model.dart';

class BookController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final BookRepository bookRepository;

  BookController(this.bookRepository);

  double opacityAnimation = 0;
  ScrollController scrollController = ScrollController();
  double containerMargin = 30;
  double containerRadius = 24;
  int commentCount = 0;
  List<BookComment> comments = [];

  @override
  void onInit() {
    super.onInit();
    scrollController.addListener(() {
      if (scrollController.offset > 200) {
        opacityAnimation = 1;
        containerMargin = 0;
        containerRadius = 0;
        update();
      } //
      else {
        opacityAnimation = 0;
        containerMargin = 30;
        containerRadius = 24;
        update();
      }
    });
  }

  void getComments(int bookId) async {
    try {
      var response = await bookRepository.getCommentsBook(bookId: bookId);
      if (response['status']) {
        comments = response['comments'];
        commentCount = comments.length;
        update();
      } //
      else {
        log('book has no comments');
      }
    } //
    catch (_) {}
  }
}
