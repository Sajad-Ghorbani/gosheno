import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gosheno/app/data/models/book_model.dart';
import 'package:gosheno/app/data/models/category_model.dart';
import 'package:gosheno/app/data/repository/book_repository.dart';
import 'package:just_audio/just_audio.dart';
import 'package:gosheno/app/modules/home/home/home_screen.dart';
import 'package:gosheno/app/modules/library/library_screen.dart';
import 'package:gosheno/app/modules/note/note_screen.dart';
import 'package:gosheno/app/modules/profile/profile_screen.dart';

class HomeController extends GetxController {
  final BookRepository bookRepository;

  HomeController({required this.bookRepository});

  final player = AudioPlayer();

  int currentIndex = 0;
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
  List<Book> mostViewedBooks = [];
  List<Book> categoryBooks = [];
  List<Book> categoryFavoriteBooks = [];
  List<Book> categoryOfferBooks = [];
  List<Book> categoryMostViewedBooks = [];

  @override
  void onInit() {
    super.onInit();
    getCategories();
    getNewestBooks();
    getBookOfCategory(1);
    getBookOfCategory(3);
    getOffersBook();
    getMostViewedBooks(false);
    getFavoriteBooks();
  }

  void initCategoryBooks(String catId) {
    getBooksOfCategory(int.parse(catId));
    getFavoriteBooks(catId: catId);
    getOffersBook(catId: catId);
    getMostViewedBooks(catId: catId,true);
  }

  void getCategories() async {
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
      log('no connection **************');
    }
  }

  void getNewestBooks() async {
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
      log('no connection **************');
    }
  }

  void getBookOfCategory(int id) async {
    try {
      Book emptyBook = Book(
        id: '',
        name: '',
        enName: '',
        author: '',
        content: '',
        bookLink: '',
        soundLink: '',
        short: '',
        about: '',
        cat: '',
        price: '',
        sPrice: '',
        pic: '',
        authorContent: '',
        ages: '',
      );
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
      log('no connection **************');
    }
  }

  void getFavoriteBooks({String? catId}) async {
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
      log('no connection **************');
    }
  }

  void getOffersBook({String? catId}) async {
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
      log('no connection **************');
    }
  }

  void getMostViewedBooks(bool fromCategory, {String? catId}) async {
    try {
      Map<String, dynamic> response =
          await bookRepository.getMostVisitedBook(catId: catId);
      if (response['status']) {
        fromCategory?
          categoryMostViewedBooks = response['books']
        :
          mostViewedBooks = response['books'];

        update();
      } //
      else {
        log(response['error']);
      }
    } catch (_) {
      log('no connection **************');
    }
  }

  void getBooksOfCategory(int id) async {
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
      log('no connection **************');
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
