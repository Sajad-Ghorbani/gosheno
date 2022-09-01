import 'package:get/get.dart';
import 'package:gosheno/app/core/utils/app_constants.dart';
import 'package:gosheno/app/data/models/book_model.dart';
import 'package:gosheno/app/data/provider/book_api_provider.dart';
import 'package:gosheno/app/data/repository/book_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LibraryController extends GetxController {
  final BookRepository _bookRepository = BookRepository(
    bookApiClient: BookApiClient(),
  );

  int selectedIndex = 0;
  bool showLoading = false;

  List<Book> allBooks = [];
  List<Book> buyBooks = [];
  List<Book> activeBooks = [];
  List<Book> favoriteBooks = [];
  int userId = -1;

  @override
  void onInit() {
    super.onInit();
    init();
  }

  init() async {
    showLoading = true;
    update();
    await getUserId();
    await getBuyBooks();
    await getActiveBooks();
    await getFavoriteBooks();
    await getAllBooks();
    showLoading = false;
    update();
  }

  Future<void> getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userId = prefs.getInt(AppConstants.userIdKey) ?? -1;
  }

  Future<void> getBuyBooks() async {
    var response = await _bookRepository.getMyBooks(id: userId);
    if (response['status']) {
      buyBooks = response['books'];
    }
  }

  Future<void> getActiveBooks() async {
    var response = await _bookRepository.getActiveBooks(userId: userId);
    if (response['status']) {
      activeBooks = response['books'];
    }
  }

  Future<void> getFavoriteBooks() async {
    var response = await _bookRepository.getMyFavoriteBooks(userId: userId);
    if (response['status']) {
      favoriteBooks = response['books'];
    }
  }

  Future getAllBooks() async {
    allBooks.addAll(buyBooks);
    if (allBooks.isNotEmpty) {
      List<Book> list = [];
      for (var book in activeBooks) {
        allBooks.any((element) => book.id == element.id)
            ? null
            : list.add(book);
      }
      allBooks.addAll(list);
    } //
    else {
      allBooks.addAll(activeBooks);
    }
    if (allBooks.isNotEmpty) {
      List<Book> list = [];
      for (var book in favoriteBooks) {
        allBooks.any((element) => book.id == element.id)
            ? null
            : list.add(book);
      }
      allBooks.addAll(list);
    } //
    else {
      allBooks.addAll(favoriteBooks);
    }
  }

  int getListLength() {
    if (selectedIndex == 0) {
      return allBooks.length;
    } else if (selectedIndex == 1) {
      return buyBooks.length;
    } else if (selectedIndex == 2) {
      return activeBooks.length;
    } else if (selectedIndex == 3) {
      return favoriteBooks.length;
    } else {
      return allBooks.length;
    }
  }

  Book getBook(int index) {
    if (selectedIndex == 0) {
      return allBooks[index];
    } else if (selectedIndex == 1) {
      return buyBooks[index];
    } else if (selectedIndex == 2) {
      return activeBooks[index];
    } else if (selectedIndex == 3) {
      return favoriteBooks[index];
    } else {
      return allBooks[index];
    }
  }
}
