import 'package:get/get.dart';
import 'package:gosheno/app/data/provider/book_api_provider.dart';
import 'package:gosheno/app/data/repository/book_repository.dart';
import 'package:http/http.dart' as http;

import 'comment_controller.dart';

class CommentBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<CommentController>(
      CommentController(
        bookRepository: BookRepository(
          bookApiClient: BookApiClient(
            httpClient: http.Client(),
          ),
        ),
      ),
    );
  }
}
