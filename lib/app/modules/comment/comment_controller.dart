import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gosheno/app/data/repository/book_repository.dart';

import '../../data/models/comment_model.dart';

class CommentController extends GetxController {
  final BookRepository bookRepository;

  CommentController({required this.bookRepository});

  TextEditingController commentController = TextEditingController();
  List<BookComment> comments = [];
  double commentRating = 3;
  String bookId = Get.parameters['bookId'] ?? '-1';

  @override
  void onInit() {
    super.onInit();
    comments = Get.arguments;
  }

  void addComment() async {
    try {
      if (commentController.text.isEmpty) return;
      var response = await bookRepository.addNewComment(
        bookId: int.parse(bookId),
        comment: commentController.text,
        rate: commentRating.toInt(),
      );
      if (response['status']) {
        commentController.clear();
        commentRating = 3;
        Get.back();
        Get.snackbar(
          '',
          'نظر شما با موفقیت ثبت شد',
          duration: const Duration(seconds: 2),
        );
      } //
      else {
        Get.back();
        log('error');
      }
    } //
    catch (e) {
      log(e.toString());
    }
  }
}
