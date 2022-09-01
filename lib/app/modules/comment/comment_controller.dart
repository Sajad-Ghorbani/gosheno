import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gosheno/app/core/utils/app_constants.dart';
import 'package:gosheno/app/data/provider/user_api_provider.dart';
import 'package:gosheno/app/data/repository/book_repository.dart';
import 'package:gosheno/app/data/repository/user_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/models/comment_model.dart';
import '../../data/models/user_model.dart';

class CommentController extends GetxController {
  final BookRepository bookRepository;

  CommentController({required this.bookRepository});

  TextEditingController commentTextController = TextEditingController();
  List<BookComment> comments = [];
  double commentRating = 3;
  String bookId = Get.parameters['bookId'] ?? '-1';

  @override
  void onInit() {
    super.onInit();
    comments = Get.arguments;
  }

  @override
  void onClose() {
    super.onClose();
    commentTextController.dispose();
  }

  void addComment() async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      if (commentTextController.text.isEmpty) return;
      int userId = pref.getInt(AppConstants.userIdKey) ?? -1;
      var response = await bookRepository.addNewComment(
        bookId: int.parse(bookId),
        comment: commentTextController.text,
        rate: commentRating.toInt(),
        userId: userId,
      );
      if (response['status']) {
        commentTextController.clear();
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

  Future<User?> getUser(int userId) async {
    try {
      UserRepository userRepository = UserRepository(
        apiClient: UserApiClient(),
      );
      User? user;
      var response = await userRepository.getUserInfo(id: userId);
      if (response['status']) {
        user = response['user'];
        return user;
      } //
      else {
        log('error in get user');
      }
    } on Exception catch (_) {
      log('no connection ***********');
    }
    return null;
  }
}
