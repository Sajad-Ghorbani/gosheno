import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gosheno/app/core/utils/app_constants.dart';
import 'package:gosheno/app/data/models/book_model.dart';
import 'package:gosheno/app/data/models/category_model.dart';
import 'package:gosheno/app/data/models/slider_model.dart';
import 'package:gosheno/app/data/repository/book_repository.dart';
import 'package:gosheno/app/routes/app_pages.dart';
import 'package:just_audio/just_audio.dart';
import 'package:gosheno/app/modules/home/home/home_screen.dart';
import 'package:gosheno/app/modules/library/library_screen.dart';
import 'package:gosheno/app/modules/note/note_screen.dart';
import 'package:gosheno/app/modules/profile/profile_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeController extends GetxController {
  final BookRepository bookRepository;

  HomeController({required this.bookRepository});

  final player = AudioPlayer();

  int currentIndex = 0;
  bool showLoading = false;
  RxBool showCategoryLoading = false.obs;
  List<Widget> listWidgets = [
    const HomeScreen(key: ValueKey(1)),
    const NoteScreen(key: ValueKey(2)),
    const LibraryScreen(key: ValueKey(3)),
    const ProfileScreen(key: ValueKey(4)),
  ];
  List<BookCategory> categories = [];
  List<Book> newestBooks = [];
  List<Book> managersBooks = [];
  List<Book> queensBooks = [];
  List<Book> favoriteBooks = [];
  List<Book> offersBooks = [];
  List<Book> topSellsBooks = [];
  List<Book> mostViewedBooks = [];
  List<Book> categoryBooks = [];
  List<Book> categoryFavoriteBooks = [];
  List<Book> categoryOfferBooks = [];
  List<Book> categoryMostViewedBooks = [];
  List<Book> myBooks = [];
  List<BookSlider> sliders = [];

  Book emptyBook = Book(
    id: '',
    name: '',
    enName: '',
    author: '',
    soundDemo: '',
    short: '',
    about: '',
    cat: '',
    price: '',
    sPrice: '',
    pic: '',
    authorContent: '',
    ages: '',
    rate: '',
    shows: '',
    tId: '',
  );

  @override
  void onInit() {
    super.onInit();
    init();
  }

  @override
  onClose() {
    super.onClose();
    player.dispose();
  }

  Future<void> init() async {
    showLoading = true;
    update();
    await getSliders();
    await getOffersBook();
    await getCategories();
    await getNewestBooks();
    await getBookOfCategory(1);
    await getBookOfCategory(3);
    await getMostViewedBooks(false);
    await getFavoriteBooks();
    await getMyBooks();
    await getTopSellsBooks();
    showLoading = false;
    update();
  }

  void initCategoryBooks(String catId) async {
    showCategoryLoading.value = true;
    await getOffersBook(catId: catId);
    await getMostViewedBooks(true, catId: catId);
    await getFavoriteBooks(catId: catId);
    await getBooksOfCategory(int.parse(catId));
    showCategoryLoading.value = false;
  }

  getSliders() async {
    try {
      Map<String, dynamic> response = await bookRepository.getSliders();
      if (response['status']) {
        sliders = response['sliders'];
        update();
      } //
      else {
        log(response['error']);
      }
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> getCategories() async {
    try {
      Map<String, dynamic> response = await bookRepository.getCategory();
      if (response['status']) {
        categories = response['cats'];
        update();
      } //
      else {
        log(response['error']);
      }
    } catch (_) {
      log('category => no connection **************');
    }
  }

  Future<void> getNewestBooks() async {
    try {
      Map<String, dynamic> response = await bookRepository.getNewestBook();
      if (response['status']) {
        newestBooks = response['books'];
        update();
      } //
      else {
        log(response['error']);
      }
    } catch (_) {
      log('newest => no connection **************');
    }
  }

  Future<void> getBookOfCategory(int id) async {
    try {
      Map<String, dynamic> response =
          await bookRepository.getBooksCategory(catId: id);
      if (response['status']) {
        if (id == 1) {
          managersBooks.add(emptyBook);
          managersBooks.addAll(response['books']);
        }
        if (id == 3) {
          queensBooks.add(emptyBook);
          queensBooks.addAll(response['books']);
        }
        update();
      } //
      else {
        log(response['error']);
      }
    } catch (_) {
      log('book of category => no connection **************');
    }
  }

  Future<void> getFavoriteBooks({String? catId}) async {
    try {
      Map<String, dynamic> response =
          await bookRepository.getFavoriteBook(catId: catId);
      if (response['status']) {
        if (catId == null) {
          favoriteBooks = response['books'];
        } //
        else {
          categoryFavoriteBooks = response['books'];
        }
        update();
      } //
      else {
        log(response['error']);
      }
    } catch (_) {
      log('favorite => no connection **************');
    }
  }

  Future<void> getOffersBook({String? catId}) async {
    try {
      Map<String, dynamic> response =
          await bookRepository.getOffersBook(catId: catId);
      if (response['status']) {
        if (catId == null) {
          offersBooks = response['books'];
        } //
        else {
          categoryOfferBooks = response['books'];
        }
        update();
      } //
      else {
        log(response['error']);
      }
    } catch (_) {
      log('offers => no connection **************');
    }
  }

  Future<void> getMostViewedBooks(bool fromCategory, {String? catId}) async {
    try {
      Map<String, dynamic> response =
          await bookRepository.getMostVisitedBook(catId: catId);
      if (response['status']) {
        fromCategory
            ? categoryMostViewedBooks = response['books']
            : mostViewedBooks = response['books'];
        update();
      } //
      else {
        log(response['error']);
      }
    } catch (_) {
      log('most view => no connection **************');
    }
  }

  Future<void> getBooksOfCategory(int id) async {
    try {
      Map<String, dynamic> response =
          await bookRepository.getBooksCategory(catId: id);
      if (response['status']) {
        categoryBooks = response['books'];
        update();
      } //
      else {
        log(response['error']);
      }
    } catch (_) {
      log('books of cat => no connection **************');
    }
  }

  void bookmarkBook(String bookId) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      int userId = prefs.getInt(AppConstants.userIdKey) ?? -1;
      if (userId == -1) {
        return;
      }
      Map<String, dynamic> response = await bookRepository.addNewFavoriteBook(
          userId: userId, bookId: int.parse(bookId));
      if (response['status']) {
        getMyBooks();
        update();
      } //
      else {
        log(response['error']);
      }
    } catch (_) {
      log('bookmark => no connection **************');
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
          await bookRepository.getMyFavoriteBooks(userId: userId);
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

  void willPopCategoryScreen() {
    categoryBooks = [];
    categoryFavoriteBooks = [];
    categoryOfferBooks = [];
    categoryMostViewedBooks = [];
    update();
  }

  void sliderTapped(BookSlider slide) async {
    if (slide.model == 'book') {
      var response = await bookRepository.getSimpleBookInfo(
        bookId: int.parse(slide.bookId),
      );
      if (response['status']) {
        Book book = response['book'];
        Get.toNamed(
          Routes.singleBookScreen,
          arguments: {book, false},
        );
      }
    } //
    else if (slide.model == 'cat') {
      String catName =
          categories.firstWhere((element) => element.id == slide.bookId).name;
      Get.toNamed(
        Routes.categoryScreen,
        parameters: {'catId': slide.bookId, 'catName': catName},
      );
    } //
    else {
      return;
    }
  }

  Future<void> getTopSellsBooks() async {
    try {
      Map<String, dynamic> response = await bookRepository.topSellerBook();
      if (response['status']) {
        topSellsBooks.add(emptyBook);
        topSellsBooks.addAll(response['books']);
        update();
      } //
      else {
        log(response['error']);
      }
    } catch (_) {
      log('top sell => no connection **************');
    }
  }
}
