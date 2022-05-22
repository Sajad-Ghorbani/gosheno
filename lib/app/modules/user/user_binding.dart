import 'package:get/get.dart';
import 'package:gosheno/app/modules/user/user_controller.dart';
import 'package:gosheno/app/data/provider/api_provider.dart';
import 'package:gosheno/app/data/repository/user_repository.dart';
import 'package:http/http.dart' as http;

class UserBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<UserController>(
      UserController(
        userRepository: UserRepository(
          apiClient: MyApiClient(
            httpClient: http.Client(),
          ),
        ),
      ),
    );
  }
}
