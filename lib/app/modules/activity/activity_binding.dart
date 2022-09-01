import 'package:get/get.dart';
import 'package:gosheno/app/data/provider/book_api_provider.dart';
import 'package:gosheno/app/data/provider/user_api_provider.dart';
import 'package:gosheno/app/data/repository/book_repository.dart';
import 'package:gosheno/app/data/repository/user_repository.dart';

import 'activity_controller.dart';

class ActivityBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<ActivityController>(
      ActivityController(
        UserRepository(
          apiClient: UserApiClient(),
        ),
        BookRepository(
          bookApiClient: BookApiClient(),
        ),
      ),
    );
  }
}
