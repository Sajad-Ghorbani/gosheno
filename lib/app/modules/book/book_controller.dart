import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gosheno/app/core/utils/app_constants.dart';
import 'package:gosheno/app/data/models/book_model.dart';
import 'package:gosheno/app/data/repository/book_repository.dart';
import 'package:gosheno/app/modules/home/home_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  Set data = Get.arguments;
  Book? book;
  bool isBookmarked = false;

  @override
  void onInit() {
    super.onInit();
    book = data.first;
    isBookmarked = data.last;
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

  @override
  onClose() {
    super.onClose();
    scrollController.dispose();
    Get.find<HomeController>().getMyBooks();
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

  getBookBookmark() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      int userId = prefs.getInt(AppConstants.userIdKey) ?? -1;
      if (userId == -1) {
        return;
      }
      Map<String, dynamic> response =
          await bookRepository.getMyFavoriteBooks(userId: userId);
      if (response['status']) {
        List<Book> myBooks = response['books'];
        isBookmarked = myBooks.any((myBook) => myBook.id == book!.id);
        update();
      } //
      else {
        log(response['error']);
      }
    } catch (_) {
      log('no connection **************');
    }
  }

  void toggleBookmark() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      int userId = prefs.getInt(AppConstants.userIdKey) ?? -1;
      if (userId == -1) {
        return;
      }
      Map<String, dynamic> response = await bookRepository.addNewFavoriteBook(
          userId: userId, bookId: int.parse(book!.id));
      if (response['status']) {
        getBookBookmark();
        update();
      } //
      else {
        log(response['error']);
      }
    } catch (_) {
      log('no connection **************');
    }
  }
}
