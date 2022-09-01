import 'package:gosheno/app/data/provider/book_api_provider.dart';

class BookRepository {
  final BookApiClient bookApiClient;

  BookRepository({required this.bookApiClient});

  /// This method is used to get all categories.
  ///
  /// Return a [Future] that contains a [Map] with the following keys:
  /// - status: true if success, false otherwise.
  /// - cats: a list of [BookCategory] if success, null otherwise.
  Future getCategory() async {
    return await bookApiClient.getCategory();
  }

  /// This method is used to get list of books in category
  ///
  /// Return of successful request is:
  /// ```
  /// {
  ///   'status': true,
  ///   'books': List of books,
  ///}
  /// ```
  Future getBooksCategory({required int catId}) async {
    return await bookApiClient.getBooksCategory(catId);
  }

  /// This method is used to get list of newest books
  ///
  /// Return of successful request is:
  ///
  /// ```
  /// {
  ///  'status': true,
  ///  'books': List of books,
  /// }
  /// ```
  Future getNewestBook() async {
    return await bookApiClient.getNewestBook();
  }

  /// This method is used to get list of favorite books
  ///
  /// Return of successful request is:
  ///
  /// ```
  /// {
  /// 'status': true,
  /// 'books': List of books,
  /// }
  /// ```
  Future getFavoriteBook({required int catId}) async {
    return await bookApiClient.getFavoriteBook(catId);
  }

  /// This method is used to get list of comments of book
  ///
  /// Return of successful request is:
  ///
  /// ```
  /// {
  /// 'status': true,
  /// 'comments': List of comments,
  /// }
  /// ```
  Future getCommentsBook({required int bookId}) async {
    return await bookApiClient.getCommentsBook(bookId);
  }

  /// This method is used to get rate of book in double.
  ///
  /// Return of successful request is:
  ///
  /// ```
  /// {
  /// 'status': true,
  /// 'bookRate': rate of book,
  /// }
  /// ```
  Future getBookRate({required int bookId}) async {
    return await bookApiClient.getBookRate(bookId);
  }

  /// This method is used to add new comment to book
  ///
  /// Return of successful request is:
  ///
  /// ```
  /// {
  /// 'status': true,
  /// }
  /// ```
  Future addNewComment({
    required int bookId,
    required String comment,
    required int rate,
    required int userId,
  }) async {
    return await bookApiClient.addNewComment(bookId, comment, rate, userId);
  }

  /// This method is used to get book info
  ///
  /// Return of successful request is:
  ///
  /// ```
  /// {
  /// 'status': true,
  /// 'book': book,
  /// }
  /// ```
  Future getBookInfo({required int bookId,required int userId}) async {
    return await bookApiClient.getBookInfo(bookId,userId);
  }

  /// This method is used to get simple info of book.
  ///
  /// [bookId] is id of book.
  ///
  /// Return a [Future] that contains a [Map] with the following keys:
  /// - status: true if success, false otherwise.
  /// - book: a [Book] if success, null otherwise.
  Future getSimpleBookInfo({required int bookId}) async {
    return await bookApiClient.getSimpleBookInfo(bookId);
  }

  /// This method is used to get list of books by search
  ///
  /// Return of successful request is:
  ///
  /// ```
  /// {
  /// 'status': true,
  /// 'books': List of books,
  /// }
  /// ```
  Future searchBook({required String search}) async {
    return await bookApiClient.searchBook(search);
  }

  /// This method is used to get list of offers books
  ///
  /// [catId] is optional.
  ///
  /// Return a [Future] that contains a [Map] with the following keys:
  /// - status: true if success, false otherwise.
  /// - books: a list of [Book] if success, null otherwise.
  Future getOffersBook({required int catId}) async {
    return await bookApiClient.getOffersBook(catId);
  }

  /// This method is used to get list of most visited books in category
  ///
  /// [catId] is id of category.
  ///
  /// Return a [Future] that contains a [Map] with the following keys:
  /// - status: true if success, false otherwise.
  /// - books: a list of [Book] if success, null otherwise.
  Future getMostVisitedBook({int? catId}) async {
    return await bookApiClient.getMostVisitedBook(catId);
  }

  /// This method is used to add a book to favorite list of user.
  ///
  /// [bookId] is id of book.
  /// [userId] is id of user.
  ///
  /// Return a [Future] that contains a [Map] with the following keys:
  /// - status: true if success, false otherwise.
  /// - error: a string if failed, null otherwise.
  Future addNewFavoriteBook({required int userId, required int bookId}) async {
    return await bookApiClient.addNewFavoriteBook(userId, bookId);
  }

  /// This method is used to get books that buy with user.
  ///
  /// [id] is the id of user.
  ///
  /// Return a [Future] that contains a [Map] with the following keys:
  /// - `status`: `true` if get user books successfully, otherwise `false`.
  /// - `books`: `List<Book>` if get user books successfully, otherwise `null`.
  Future getMyBooks({required int id}) async {
    return await bookApiClient.getMyBooks(id);
  }

  /// This method is used to get top seller books.
  ///
  /// Return a [Future] that contains a [Map] with the following keys:
  /// - `status`: `true` if get top seller books successfully, otherwise `false`.
  /// - `books`: `List<Book>` if get top seller books successfully, otherwise `null`.
  Future topSellerBook({required int catId}) async {
    return await bookApiClient.topSellerBook(catId);
  }

  /// This method is used to get top sliders.
  ///
  /// Return a [Future] that contains a [Map] with the following keys:
  /// - `status`: `true` if get top sliders successfully, otherwise `false`.
  /// - `sliders`: `List<Slider>` if get top sliders successfully, otherwise `null`.
  Future getSliders() async {
    return await bookApiClient.getSliders();
  }

  /// This method is used to get books that is active for user.
  ///
  /// [userId] is the id of user.
  ///
  /// Return a [Future] that contains a [Map] with the following keys:
  /// - `status`: `true` if get user books successfully, otherwise `false`.
  /// - `books`: `List<Book>` if get user books successfully, otherwise `null`.
  Future getActiveBooks({required int userId}) async {
    return await bookApiClient.getActiveBooks(userId);
  }

  /// This method is used to get favorite books for user.
  ///
  /// [userId] is the id of user.
  ///
  /// Return a [Future] that contains a [Map] with the following keys:
  /// - `status`: `true` if get favorite books successfully, otherwise `false`.
  /// - `books`: `List<Book>` if get favorite books successfully, otherwise `null`.
  Future getMyFavoriteBooks({required int userId}) async {
    return await bookApiClient.getMyFavoriteBooks(userId);
  }

  /// This method is used to add book to active books.
///
/// [bookId] is the id of book.
/// [userId] is the id of user.
///
/// Return a [Future] that contains a [Map] with the following keys:
/// - `status`: `true` if add book to active books successfully, otherwise `false`.
///
  Future addActiveBook({required int userId, required int bookId,required String bookName}) async {
    return await bookApiClient.addActiveBook(userId, bookId,bookName);
  }
}
