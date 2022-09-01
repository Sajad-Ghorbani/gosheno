import 'package:get/get.dart';
import 'package:gosheno/app/data/provider/book_api_provider.dart';
import 'package:gosheno/app/modules/book/book_controller.dart';
import 'package:gosheno/app/data/repository/book_repository.dart';

class BookBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<BookController>(
      BookController(
        BookRepository(
          bookApiClient: BookApiClient(),
        ),
      ),
    );
  }
}
