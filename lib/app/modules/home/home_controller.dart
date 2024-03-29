import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gosheno/app/core/utils/app_constants.dart';
import 'package:gosheno/app/data/models/book_model.dart';
import 'package:gosheno/app/data/models/slider_model.dart';
import 'package:gosheno/app/data/repository/book_repository.dart';
import 'package:gosheno/app/routes/app_pages.dart';
import 'package:just_audio/just_audio.dart';
import 'package:gosheno/app/modules/home/home/home_screen.dart';
import 'package:gosheno/app/modules/library/library_screen.dart';
import 'package:gosheno/app/modules/category/category_screen.dart';
import 'package:gosheno/app/modules/profile/profile/profile_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeController extends GetxController {
  final BookRepository bookRepository;

  HomeController({required this.bookRepository});

  final player = AudioPlayer();

  int currentIndex = 0;
  bool showLoading = false;
  bool showCategoryLoading = false;
  List<Widget> listWidgets = [
    const HomeScreen(key: ValueKey(1)),
    const CategoryScreen(key: ValueKey(2)),
    const LibraryScreen(key: ValueKey(3)),
    const ProfileScreen(key: ValueKey(4)),
  ];
  List<Book> newestBooks = [];
  List<Book> managersBooks = [];
  List<Book> queensBooks = [];
  List<Book> favoriteBooks = [];
  List<Book> offersBooks = [];
  List<Book> topSellsBooks = [];
  List<Book> mostViewedBooks = [];
  List<Book> myBooks = [];
  List<BookSlider> sliders = [];

  Book emptyBook = Book(
    id: -1,
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
    rate: '',
    shows: '',
    tId: '',
    createdAt: '',
    updatedAt: '',
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
    await getOffersBook(catId: 0);
    await getNewestBooks();
    await getBookOfCategory(1);
    await getBookOfCategory(3);
    await getMostViewedBooks(catId: 0);
    await getFavoriteBooks(catId: 0);
    await getMyBooks();
    await getTopSellsBooks(catId: 0);
    showLoading = false;
    update();
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
          managersBooks = [];
          managersBooks.add(emptyBook);
          managersBooks.addAll(response['books']);
        }
        if (id == 3) {
          queensBooks = [];
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

  Future<void> getFavoriteBooks({required int catId}) async {
    try {
      Map<String, dynamic> response =
          await bookRepository.getFavoriteBook(catId: catId);
      if (response['status']) {
        favoriteBooks = response['books'];
      } //
      else {
        log(response['error']);
      }
    } catch (_) {
      log('favorite => no connection **************');
    }
  }

  Future<void> getOffersBook({required int catId}) async {
    try {
      Map<String, dynamic> response =
          await bookRepository.getOffersBook(catId: catId);
      if (response['status']) {
        offersBooks = response['books'];
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
          await bookRepository.getMostVisitedBook(catId: catId);
      if (response['status']) {
        mostViewedBooks = response['books'];
        update();
      } //
      else {
        log(response['error']);
      }
    } catch (_) {
      log('most view => no connection **************');
    }
  }

  Future<void> getTopSellsBooks({required int catId}) async {
    try {
      topSellsBooks = [];
      Map<String, dynamic> response =
          await bookRepository.topSellerBook(catId: catId);
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
      Map<String, dynamic> response = await bookRepository.addNewFavoriteBook(
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
      log(_.toString());
    }
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
          parameters: {'tag': 'slider-${book.enName}'},
        );
      }
    } //
    else if (slide.model == 'cat') {
      List categories = [];
      Map<String, dynamic> response = await bookRepository.getCategory();
      if (response['status']) {
        categories = response['cats'];
      } //
      else {
        log(response['error']);
      }
      String catName = categories
          .firstWhere((element) => element.id.toString() == slide.bookId)
          .name;
      Get.toNamed(
        Routes.categoryScreen,
        parameters: {'catId': slide.bookId, 'catName': catName},
      );
    } //
    else {
      return;
    }
  }
}
