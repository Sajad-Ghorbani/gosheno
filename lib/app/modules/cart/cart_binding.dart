import 'package:get/get.dart';
import 'package:gosheno/app/data/provider/book_api_provider.dart';
import 'package:gosheno/app/data/repository/book_repository.dart';

import 'cart_controller.dart';

class CartBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CartController>(
      () => CartController(
        BookRepository(
          bookApiClient: BookApiClient(),
        ),
      ),
    );
  }
}
