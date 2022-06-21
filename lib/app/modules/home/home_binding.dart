import 'package:get/get.dart';
import 'package:gosheno/app/data/provider/book_api_provider.dart';
import 'package:gosheno/app/data/repository/book_repository.dart';
import 'package:gosheno/app/modules/home/home_controller.dart';
import 'package:http/http.dart' as http;

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<HomeController>(
      HomeController(
        bookRepository: BookRepository(
          bookApiClient: BookApiClient(
            httpClient: http.Client(),
          ),
        ),
      ),
    );
  }
}
