import 'package:get/get.dart';
import 'package:gosheno/app/modules/single_book/single_book_controller.dart';
import 'package:gosheno/app/data/provider/api_provider.dart';
import 'package:gosheno/app/data/repository/repository.dart';
import 'package:http/http.dart' as http;

class SingleBookBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<SingleBookController>(
      SingleBookController(
        MyRepository(
          apiClient: MyApiClient(
            httpClient: http.Client(),
          ),
        ),
      ),
    );
  }
}
