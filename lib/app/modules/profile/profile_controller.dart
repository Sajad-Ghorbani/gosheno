import 'package:get/get.dart';
import 'package:gosheno/app/routes/app_pages.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileController extends GetxController{

  void logout()async{
    Get.offAllNamed(Routes.loginScreen);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }
}