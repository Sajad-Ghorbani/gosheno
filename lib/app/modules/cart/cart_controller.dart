import 'package:get/get.dart';
import 'package:gosheno/app/core/utils/app_constants.dart';
import 'package:gosheno/app/data/models/book_model.dart';
import 'package:gosheno/app/data/repository/book_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartController extends GetxController {
  final BookRepository _bookRepository;

  CartController(this._bookRepository);

  List<Book> books = [];
  // List<int> booksCount = [];
  int totalCartPrice = 0;
  bool isLoading = false;

  @override
  void onInit() {
    super.onInit();
    getCart();
  }

  void getCart() async {
    isLoading = true;
    update();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> cartBooks = prefs.getStringList(AppConstants.cartKey) ?? [];
    if (cartBooks.isNotEmpty) {
      for (var item in cartBooks) {
        int bookId = int.parse(item.split('/')[0]);
        // int bookCount = int.parse(item.split('/')[1]);
        var response = await _bookRepository.getSimpleBookInfo(bookId: bookId);
        Book book = response['book'];
        books.add(book);
        // booksCount.add(bookCount);
      }
    } //
    else {
      books.clear();
      // booksCount.clear();
    }
    getTotalPrice();
    isLoading = false;
    update();
  }

  //
  // Future addBook(int index) async {
  //   booksCount[index]++;
  //   update();
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   List<String> cartBooks = prefs.getStringList(AppConstants.cartKey) ?? [];
  //   if (cartBooks.isNotEmpty) {
  //     String item = cartBooks[index];
  //     int bookId = int.parse(item.split('/')[0]);
  //     int bookCount = int.parse(item.split('/')[1]);
  //     bookCount++;
  //     cartBooks[index] = '$bookId/$bookCount';
  //   }
  //   await prefs.setStringList(AppConstants.cartKey, cartBooks);
  //   await getTotalPrice();
  // }
  //
  // Future decreaseBook(int index) async {
  //   if (booksCount[index] > 1) {
  //     booksCount[index]--;
  //     update();
  //     SharedPreferences prefs = await SharedPreferences.getInstance();
  //     List<String> cartBooks = prefs.getStringList(AppConstants.cartKey) ?? [];
  //     if (cartBooks.isNotEmpty) {
  //       String item = cartBooks[index];
  //       int bookId = int.parse(item.split('/')[0]);
  //       int bookCount = int.parse(item.split('/')[1]);
  //       bookCount--;
  //       cartBooks[index] = '$bookId/$bookCount';
  //     }
  //     await prefs.setStringList(AppConstants.cartKey, cartBooks);
  //     await getTotalPrice();
  //   }
  // }

  Future removeBook(int index) async {
    books.removeAt(index);
    // booksCount.removeAt(index);
    update();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> cartBooks = prefs.getStringList(AppConstants.cartKey) ?? [];
    if (cartBooks.isNotEmpty) {
      cartBooks.removeAt(index);
    }
    await prefs.setStringList(AppConstants.cartKey, cartBooks);
    getTotalPrice();
  }

  void getTotalPrice() {
    totalCartPrice = 0;
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // List<String> cartBooks = prefs.getStringList(AppConstants.cartKey) ?? [];
    // if (cartBooks.isNotEmpty) {
    //   for (var item in cartBooks) {
    //     int bookId = int.parse(item.split('/')[0]);
    //     int bookCount = int.parse(item.split('/')[1]);
    //     var response = await _bookRepository.getSimpleBookInfo(bookId: bookId);
    //     Book book = response['book'];
    //     totalCartPrice += (book.offCount > 0
    //             ? int.parse(book.sPrice!)
    //             : int.parse(book.price)) *
    //         bookCount;
    //   }
    // } //
    if (books.isNotEmpty) {
      for (var item in books) {
        totalCartPrice += (item.offCount > 0
                ? int.parse(item.sPrice!)
                : int.parse(item.price)) ;
            // booksCount[books.indexOf(item)];
      }
    } //
    else {
      totalCartPrice = 0;
    }
    update();
  }
}
