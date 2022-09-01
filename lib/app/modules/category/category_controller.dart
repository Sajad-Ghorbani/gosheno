import 'dart:developer';

import 'package:get/get.dart';
import 'package:gosheno/app/core/utils/app_constants.dart';
import 'package:gosheno/app/data/models/book_model.dart';
import 'package:gosheno/app/data/models/category_model.dart';
import 'package:gosheno/app/data/provider/book_api_provider.dart';
import 'package:gosheno/app/data/repository/book_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CategoryController extends GetxController {
  final BookRepository _bookRepository = BookRepository(
    bookApiClient: BookApiClient(),
  );

  bool showLoading = false;
  bool showCategoryLoading = true;
  List<BookCategory> categories = [];
  List<Book> categoryBooks = [];
  List<Book> categoryFavoriteBooks = [];
  List<Book> categoryOfferBooks = [];
  List<Book> categoryMostViewedBooks = [];
  List<Book> myBooks = [];

  @override
  void onInit() {
    super.onInit();
    getCategories();
  }

  Future<void> getCategories() async {
    showLoading = true;
    update();
    try {
      Map<String, dynamic> response = await _bookRepository.getCategory();
      if (response['status']) {
        categories = response['cats'];
      } //
      else {
        log(response['error']);
      }
    } //
    catch (_) {
      log('category => no connection **************');
    }
    showLoading = false;
    update();
  }

  void initCategoryBooks(int catId) async {
    showCategoryLoading = true;
    await getOffersBook(catId: catId);
    await getMostViewedBooks(catId: catId);
    await getFavoriteBooks(catId: catId);
    await getBooksOfCategory(catId);
    await getMyBooks();
    showCategoryLoading = false;
    update();
  }

  Future<void> getOffersBook({required int catId}) async {
    try {
      Map<String, dynamic> response =
          await _bookRepository.getOffersBook(catId: catId);
      if (response['status']) {
        categoryOfferBooks = response['books'];
      } //
      else {
        log(response['error']);
      }
    } catch (_) {
      log('offers => no connection **************');
    }
  }

  Future<void> getMostViewedBooks({int? catId}) async {
    try {
      Map<String, dynamic> response =
          await _bookRepository.getMostVisitedBook(catId: catId);
      if (response['status']) {
        categoryMostViewedBooks = response['books'];
      } //
      else {
        log(response['error']);
      }
    } catch (_) {
      log('most view => no connection **************');
    }
  }

  Future<void> getFavoriteBooks({required int catId}) async {
    try {
      Map<String, dynamic> response =
          await _bookRepository.getFavoriteBook(catId: catId);
      if (response['status']) {
        categoryFavoriteBooks = response['books'];
      } //
      else {
        log(response['error']);
      }
    } catch (_) {
      log('favorite => no connection **************');
    }
  }

  Future<void> getBooksOfCategory(int id) async {
    try {
      Map<String, dynamic> response =
          await _bookRepository.getBooksCategory(catId: id);
      if (response['status']) {
        categoryBooks = response['books'];
      } //
      else {
        log(response['error']);
      }
    } catch (_) {
      log('books of cat => no connection **************');
    }
  }

  getMyBooks() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      int userId = prefs.getInt(AppConstants.userIdKey) ?? -1;
      if (userId == -1) {
        return;
      }
      Map<String, dynamic> response =
      await _bookRepository.getMyFavoriteBooks(userId: userId);
      if (response['status']) {
        myBooks = response['books'];
        update();
      } //
      else {
        log(response['error']);
      }
    } catch (_) {
      log('my book => no connection **************');
    }
  }

  void bookmarkBook(Book book) async {
    try {
      if (myBooks.any((element) => element.id == book.id)) {
        myBooks.removeWhere((element) => element.id == book.id);
      } else {
        myBooks.add(book);
      }
      update();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      int userId = prefs.getInt(AppConstants.userIdKey) ?? -1;
      if (userId == -1) {
        return;
      }
      Map<String, dynamic> response = await _bookRepository.addNewFavoriteBook(
          userId: userId, bookId: book.id);
      if (response['status']) {
        await getMyBooks();
        update();
      } //
      else {
        log(response['error']);
      }
    } catch (_) {
      log('bookmark => no connection **************');
    }
  }

  void willPopCategoryScreen() {
    categoryBooks = [];
    categoryFavoriteBooks = [];
    categoryOfferBooks = [];
    categoryMostViewedBooks = [];
    update();
  }
}
