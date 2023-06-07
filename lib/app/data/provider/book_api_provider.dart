import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:gosheno/app/core/utils/app_constants.dart';
import 'package:gosheno/app/data/models/book_model.dart';
import 'package:gosheno/app/data/models/category_model.dart';
import 'package:gosheno/app/data/models/comment_model.dart';
import 'package:gosheno/app/data/models/slider_model.dart';

class BookApiClient {
  Dio dio = Dio(AppConstants.dioOptions);

  Future getCategory() async {
    try {
      var response = await dio.request(
        '/categories',
        options: Options(
          method: 'GET',
        ),
      );
      if (response.statusCode == 200) {
        List result = response.data;
        List<BookCategory> cats = [];
        for (var item in result) {
          cats.add(BookCategory.fromJson(item));
        }
        return {
          'status': true,
          'cats': cats,
        };
      } else {
        return {
          'status': false,
        };
      }
    } //
    catch (_) {}
  }

  Future getBooksCategory(int catId) async {
    try {
      var response = await dio.request(
        '/cat/$catId',
        options: Options(
          method: 'GET',
        ),
      );
      if (response.statusCode == 200) {
        List result = response.data;
        List<Book> books = [];
        for (var item in result) {
          books.add(Book.fromJson(item));
        }
        return {
          'status': true,
          'books': books,
        };
      } else {
        return {
          'status': false,
        };
      }
    } //
    catch (_) {}
  }

  Future getNewestBook() async {
    try {
      var response = await dio.request(
        '/news',
        options: Options(
          method: 'GET',
        ),
      );
      if (response.statusCode == 200) {
        List result = response.data;
        List<Book> books = [];
        for (var item in result) {
          books.add(Book.fromJson(item));
        }
        return {
          'status': true,
          'books': books,
        };
      } else {
        return {
          'status': false,
        };
      }
    } //
    catch (e) {
      log(e.toString());
    }
  }

  Future getFavoriteBook(int catId) async {
    try {
      var response = await dio.get(
        '/favbooks/$catId',
        options: Options(
          method: 'GET',
        ),
      );
      if (response.statusCode == 200) {
        List result = response.data;
        List<Book> books = [];
        for (var item in result) {
          books.add(Book.fromJson(item));
        }
        return {
          'status': true,
          'books': books,
        };
      } else {
        return {
          'status': false,
        };
      }
    } //
    catch (_) {}
  }

  Future addNewFavoriteBook(int userId, int bookId) async {
    try {
      var response = await dio.post(
        '/addfav',
        options: Options(
          method: 'POST',
        ),
        data: FormData.fromMap({
          'uid': userId.toString(),
          'book': bookId.toString(),
        }),
      );
      if (response.statusCode == 200) {
        var result = response.data;
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
    catch (_) {
      log(_.toString());
    }
  }

  Future getCommentsBook(int bookId) async {
    try {
      var response = await dio.get(
        '/comments/$bookId',
        options: Options(
          method: 'GET',
        ),
      );
      if (response.statusCode == 200) {
        List result = response.data;
        List<BookComment> comments = [];
        for (var item in result) {
          comments.add(BookComment.fromJson(item));
        }
        return {
          'status': true,
          'comments': comments,
        };
      } else {
        return {
          'status': false,
        };
      }
    } //
    catch (_) {}
  }

  Future getBookRate(int bookId) async {
    try {
      var response = await dio.get(
        '/rate/book/$bookId',
        options: Options(
          method: 'GET',
        ),
      );
      if (response.statusCode == 200) {
        var result = response.data;
        return {
          'status': true,
          'bookRate': double.parse(result['result']),
        };
      } else {
        return {
          'status': false,
        };
      }
    } //
    catch (_) {}
  }

  Future addNewComment(int bookId, String comment, int rate, int userId) async {
    try {
      var response = await dio.post(
        '/comments/new',
        options: Options(
          method: 'POST',
        ),
        data: FormData.fromMap({
          'book': bookId.toString(),
          'comment': comment,
          'rate': rate.toString(),
          'uid': userId.toString(),
        }),
      );
      if (response.statusCode == 200) {
        return {
          'status': true,
        };
      } else {
        var result = response.data;
        return {
          'status': false,
          'error': result['errors']['comment'],
        };
      }
    } //
    catch (_) {}
  }

  Future getBookInfo(int bookId, int userId) async {
    try {
      var response = await dio.post(
        '/bookinfo',
        options: Options(
          method: 'POST',
        ),
        data: FormData.fromMap({
          'book': bookId.toString(),
          'uid': userId.toString(),
        }),
      );
      if (response.statusCode == 200) {
        var result = response.data;
        return {
          'status': true,
          'book': Book.fromJson(result),
        };
      } else {
        return {
          'status': false,
        };
      }
    } //
    catch (_) {}
  }

  Future getSimpleBookInfo(int bookId) async {
    try {
      var response = await dio.get(
        '/info/$bookId',
        options: Options(
          method: 'GET',
        ),
      );
      if (response.statusCode == 200) {
        var result = response.data;
        log(result.toString());
        Book book = Book.fromJson(result);
        return {
          'status': true,
          'book': book,
        };
      } else {
        return {
          'status': false,
        };
      }
    } //
    on DioException catch (e) {
      log(e.toString());
      return {
        'status': false,
      };
    }
  }

  Future searchBook(String search) async {
    try {
      var response = await dio.post(
        '/searchbook',
        options: Options(
          method: 'POST',
        ),
        data: FormData.fromMap({
          'search': search,
          'category': '',
        }),
      );
      if (response.statusCode == 200) {
        var result = response.data;
        List<Book> books = [];
        for (var item in result['data']) {
          books.add(Book.fromJson(item));
        }
        return {
          'status': true,
          'books': books,
        };
      } else {
        return {
          'status': false,
        };
      }
    } //
    catch (_) {
      log(_.toString());
    }
  }

  Future getOffersBook(int catId) async {
    try {
      var response = await dio.get(
        '/offers/$catId',
        options: Options(
          method: 'GET',
        ),
      );
      if (response.statusCode == 200) {
        List result = response.data;
        List<Book> books = [];

        for (var item in result) {
          books.add(Book.fromJson(item));
        }
        return {
          'status': true,
          'books': books,
        };
      } else {
        return {
          'status': false,
        };
      }
    } //
    catch (_) {
      log('error -get');
      log(_.toString());
    }
  }

  Future getMostVisitedBook(int? catId) async {
    try {
      var response = await dio.get(
        '/visited/$catId',
        options: Options(
          method: 'GET',
        ),
      );
      if (response.statusCode == 200) {
        List result = response.data;
        List<Book> books = [];
        for (var item in result) {
          books.add(Book.fromJson(item));
        }
        return {
          'status': true,
          'books': books,
        };
      } else {
        return {
          'status': false,
        };
      }
    } //
    catch (_) {}
  }

  Future getMyBooks(int id) async {
    try {
      var response = await dio.get(
        '/mybooks/$id',
        options: Options(
          method: 'GET',
        ),
      );
      if (response.statusCode == 200) {
        var result = response.data;
        List<Book> books = [];
        for (var item in result) {
          books.add(Book.fromJson(item));
        }
        return {
          'status': true,
          'books': books,
        };
      } else {
        return {
          'status': false,
        };
      }
    } //
    catch (_) {}
  }

  Future topSellerBook(int catId) async {
    try {
      var response = await dio.get(
        '/topsells/$catId',
        options: Options(
          method: 'GET',
        ),
      );
      if (response.statusCode == 200) {
        var result = response.data;
        log(result.toString());
        List<Book> books = [];
        for (var item in result) {
          var bookResponse = await getSimpleBookInfo(int.parse(item['book']));
          if (bookResponse['status']) {
            books.add(bookResponse['book']);
          }
        }
        return {
          'status': true,
          'books': books,
        };
      } else {
        return {
          'status': false,
        };
      }
    } //
    catch (e) {
      log(e.toString());
      return {
        'status': false,
      };
    }
  }

  Future getSliders() async {
    try {
      var response = await dio.get(
        '/sliders',
        options: Options(
          method: 'GET',
        ),
      );
      if (response.statusCode == 200) {
        var result = response.data;
        List<BookSlider> sliders = [];
        for (var item in result) {
          sliders.add(BookSlider.fromJson(item));
        }
        return {
          'status': true,
          'sliders': sliders,
        };
      } else {
        return {
          'status': false,
        };
      }
    } //
    catch (e) {
      log(e.toString());
    }
  }

  Future getActiveBooks(int id) async {
    try {
      var response = await dio.get(
        '/activebooks/$id',
        options: Options(
          method: 'GET',
        ),
      );
      if (response.statusCode == 200) {
        var result = response.data;
        List<Book> books = [];
        for (var item in result) {
          books.add(Book.fromJson(item));
        }
        return {
          'status': true,
          'books': books,
        };
      } else {
        return {
          'status': false,
        };
      }
    } //
    catch (e) {
      log(e.toString());
    }
  }

  Future getMyFavoriteBooks(int id) async {
    try {
      var response = await dio.request(
        '/myfav/$id',
        options: Options(
          method: 'GET',
        ),
      );
      if (response.statusCode == 200) {
        var result = response.data;
        List<Book> books = [];
        for (var item in result) {
          books.add(Book.fromJson(item));
        }
        return {
          'status': true,
          'books': books,
        };
      } else {
        return {
          'status': false,
        };
      }
    } //
    catch (e) {
      log(e.toString());
    }
  }

  Future addActiveBook(int userId, int bookId, String bookName) async {
    try {
      var response = await dio.get(
        '/addactive/$userId/$bookId',
        options: Options(
          method: 'GET',
        ),
      );
      if (response.statusCode == 200) {
        return {
          'status': true,
          'message': '$bookName به لیست کتابهای اشتراکی اضافه شد',
        };
      } //
      else {
        return {
          'status': false,
          'message': 'خطا در اضافه کردن کتاب به لیست کتابهای اشتراکی',
        };
      }
    } //
    on DioException catch (e) {
      if (e.response!.statusCode == 403) {
        return {
          'status': false,
          'message': 'این کتاب در لیست کتاب های اشتراکی شما قرار دارد',
        };
      } //
      else if (e.response!.statusCode == 401) {
        return {
          'status': false,
          'message': 'اشتراک شما به پایان رسیده است',
        };
      } //
      else {
        return {
          'status': false,
          'message': 'خطا در اضافه کردن کتاب به لیست کتابهای اشتراکی',
        };
      }
    } catch (e) {
      log(e.toString());
    }
  }
}
