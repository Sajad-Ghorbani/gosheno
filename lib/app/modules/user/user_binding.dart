import 'package:get/get.dart';
import 'package:gosheno/app/data/provider/book_api_provider.dart';
import 'package:gosheno/app/data/repository/book_repository.dart';
import 'package:gosheno/app/modules/user/user_controller.dart';
import 'package:gosheno/app/data/provider/user_api_provider.dart';
import 'package:gosheno/app/data/repository/user_repository.dart';

class UserBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<UserController>(
      UserController(
        userRepository: UserRepository(
          apiClient: UserApiClient(),
        ),
        bookRepository: BookRepository(
          bookApiClient: BookApiClient(),
        ),
      ),
    );
  }
}
