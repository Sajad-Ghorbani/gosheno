import 'package:get/get.dart';
import 'package:gosheno/app/controllers/single_book_controller.dart';

class SingleBookBinding implements Bindings{
  @override
  void dependencies() {
    Get.put<SingleBookController>(SingleBookController());
  }
}