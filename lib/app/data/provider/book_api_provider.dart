import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:gosheno/app/core/utils/app_constants.dart';
import 'package:gosheno/app/data/models/book_model.dart';
import 'package:gosheno/app/data/models/category_model.dart';
import 'package:gosheno/app/data/models/comment_model.dart';
import 'package:http/http.dart' as http;

class BookApiClient {
  final http.Client httpClient;

  BookApiClient({required this.httpClient});

  String baseUrl = webserviceBaseUrl;
  Map<String, String> headers = {
    'Content-Type': 'application/x-www-form-urlencoded',
    HttpHeaders.authorizationHeader: 'bd6d553fc3af11c7ba3793d87ef28e53',
  };

  Future getCategory() async {
    try {
      var response = await httpClient.post(
        Uri.parse(baseUrl),
        headers: headers,
        body: {
          'RequestType': 'cats',
        },
      );
      if (response.statusCode == 200) {
        List result = json.decode(response.body);
        if (result[0] != 'error') {
          List<BookCategory> cats = [];
          for (var item in result) {
            cats.add(BookCategory.fromJson(item));
          }
          return {
            'status': true,
            'cats': cats,
          };
        } //
        else {
          return {
            'status': false,
            'error': result[1],
          };
        }
      } else {
        log('error -get');
      }
    } //
    catch (_) {}
  }

  Future getBooksCategory(int catId) async {
    try {
      var response = await httpClient.post(
        Uri.parse(baseUrl),
        headers: headers,
        body: {
          'RequestType': 'bookcat',
          'cat': catId.toString(),
        },
      );
      if (response.statusCode == 200) {
        List result = json.decode(response.body);
        if (result[0] != 'error') {
          List<Book> books = [];
          for (var item in result) {
            books.add(Book.fromJson(item));
          }
          return {
            'status': true,
            'books': books,
          };
        } //
        else {
          return {
            'status': false,
            'error': result[1],
          };
        }
      } else {
        log('error -get');
      }
    } //
    catch (_) {}
  }

  Future getNewestBook() async {
    try {
      var response = await httpClient.post(
        Uri.parse(baseUrl),
        headers: headers,
        body: {
          'RequestType': 'newestbook',
        },
      );
      if (response.statusCode == 200) {
        List result = json.decode(response.body);
        if (result[0] != 'error') {
          List<Book> books = [];
          for (var item in result) {
            books.add(Book.fromJson(item));
          }
          return {
            'status': true,
            'books': books,
          };
        } //
        else {
          return {
            'status': false,
            'error': result[1],
          };
        }
      } else {
        log('error -get');
      }
    } //
    catch (_) {}
  }

  Future getFavoriteBook(String? catId) async {
    try {
      var response = await httpClient.post(
        Uri.parse(baseUrl),
        headers: headers,
        body: {
          'RequestType': 'favoritesbook',
          'cat': catId ?? '',
        },
      );
      if (response.statusCode == 200) {
        List result = json.decode(response.body);
        if (result[0] != 'error') {
          List<Book> books = [];
          for (var item in result) {
            books.add(Book.fromJson(item));
          }
          return {
            'status': true,
            'books': books,
          };
        } //
        else {
          return {
            'status': false,
            'error': result[1],
          };
        }
      } else {
        log('error -get');
      }
    } //
    catch (_) {}
  }

  Future addNewFavoriteBook(int userId, int bookId) async {
    try {
      var response = await httpClient.post(
        Uri.parse(baseUrl),
        headers: headers,
        body: {
          'RequestType': 'newfavorite',
          'uid': userId.toString(),
          'book': bookId.toString(),
        },
      );
      if (response.statusCode == 200) {
        var result = json.decode(response.body);
        if (result[0] != 'error') {
          return {
            'status': true,
          };
        } //
        else {
          return {
            'status': false,
            'error': result[1],
          };
        }
      } else {
        log('error -get');
      }
    } //
    catch (_) {}
  }

  Future getCommentsBook(int bookId) async {
    try {
      var response = await httpClient.post(
        Uri.parse(baseUrl),
        headers: headers,
        body: {
          'RequestType': 'comments',
          'book': bookId.toString(),
        },
      );
      if (response.statusCode == 200) {
        List result = json.decode(response.body);
        if (result[0] != 'error') {
          List<BookComment> comments = [];
          for (var item in result) {
            comments.add(BookComment.fromJson(item));
          }
          return {
            'status': true,
            'comments': comments,
          };
        } //
        else {
          return {
            'status': false,
            'error': result[1],
          };
        }
      } else {
        log('error -get');
      }
    } //
    catch (_) {}
  }

  Future getBookRate(int bookId) async {
    try {
      var response = await httpClient.post(
        Uri.parse(baseUrl),
        headers: headers,
        body: {
          'RequestType': 'bookrate',
          'book': bookId.toString(),
        },
      );
      if (response.statusCode == 200) {
        var result = json.decode(response.body);
        if (result[0] != 'error') {
          return {
            'status': true,
            'bookRate': double.parse(result['rate_book']),
          };
        } //
        else {
          return {
            'status': false,
            'error': result[1],
          };
        }
      } else {
        log('error -get');
      }
    } //
    catch (_) {}
  }

  Future addNewComment(int bookId, String comment, int rate) async {
    try {
      var response = await httpClient.post(
        Uri.parse(baseUrl),
        headers: headers,
        body: {
          'RequestType': 'newcomment',
          'book': bookId.toString(),
          'comment': comment,
          'rate': rate.toString(),
        },
      );
      if (response.statusCode == 200) {
        var result = json.decode(response.body);
        if (result[0] != 'error') {
          return {
            'status': true,
          };
        } //
        else {
          return {
            'status': false,
            'error': result[1],
          };
        }
      } else {
        log('error -get');
      }
    } //
    catch (_) {}
  }

  Future getBookInfo(int bookId) async {
    try {
      var response = await httpClient.post(
        Uri.parse(baseUrl),
        headers: headers,
        body: {
          'RequestType': 'bookinfo',
          'book': bookId.toString(),
        },
      );
      if (response.statusCode == 200) {
        var result = json.decode(response.body);
        if (result[0] != 'error') {
          return {
            'status': true,
            'book': Book.fromJson(result),
          };
        } //
        else {
          return {
            'status': false,
            'error': result[1],
          };
        }
      } else {
        log('error -get');
      }
    } //
    catch (_) {}
  }

  Future searchBook(String search) async {
    try {
      var response = await httpClient.post(
        Uri.parse(baseUrl),
        headers: headers,
        body: {
          'RequestType': 'searchinfo',
          'search': search,
        },
      );
      if (response.statusCode == 200) {
        List result = json.decode(response.body);
        log(result.toString());
        if (result[0] != 'error') {
          List<Book> books = [];
          for (var item in result) {
            books.add(Book.fromJson(item));
          }
          return {
            'status': true,
            'books': books,
          };
        } //
        else {
          return {
            'status': false,
            'error': result[1],
          };
        }
      } else {
        log('error -get');
      }
    } //
    catch (_) {}
  }

  Future getOffersBook(String? catId) async {
    try {
      var response = await httpClient.post(
        Uri.parse(baseUrl),
        headers: headers,
        body: {
          'RequestType': 'offers',
          'cat': catId ?? '',
        },
      );
      if (response.statusCode == 200) {
        List result = json.decode(response.body);
        if (result[0] != 'error') {
          List<Book> books = [];
          for (var item in result) {
            books.add(Book.fromJson(item));
          }
          return {
            'status': true,
            'books': books,
          };
        } //
        else {
          return {
            'status': false,
            'error': result[1],
          };
        }
      } else {
        log('error -get');
      }
    } //
    catch (_) {}
  }

  Future getMostVisitedBook(String? catId) async {
    try {
      var response = await httpClient.post(
        Uri.parse(baseUrl),
        headers: headers,
        body: {
          'RequestType': 'visited',
          'cat': catId ?? '',
        },
      );
      if (response.statusCode == 200) {
        List result = json.decode(response.body);
        if (result[0] != 'error') {
          List<Book> books = [];
          for (var item in result) {
            books.add(Book.fromJson(item));
          }
          return {
            'status': true,
            'books': books,
          };
        } //
        else {
          return {
            'status': false,
            'error': result[1],
          };
        }
      } else {
        log('error -get');
      }
    } //
    catch (_) {}
  }
}
