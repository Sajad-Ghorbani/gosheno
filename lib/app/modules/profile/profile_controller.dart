import 'dart:developer';

import 'package:get/get.dart';
import 'package:gosheno/app/core/utils/app_constants.dart';
import 'package:gosheno/app/data/provider/user_api_provider.dart';
import 'package:gosheno/app/data/repository/user_repository.dart';
import 'package:gosheno/app/routes/app_pages.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../data/models/user_model.dart';

class ProfileController extends GetxController {
  final UserRepository _userRepository = UserRepository(
    apiClient: UserApiClient(
      httpClient: http.Client(),
    ),
  );
  User? user;
  String userName = '';
  bool showLoading = true;

  @override
  onInit() {
    super.onInit();
    getUserInfo();
  }

  void logout() async {
    Get.offAllNamed(Routes.loginScreen);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  void getUserInfo() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    int? userId = pref.getInt(AppConstants.userIdKey);
    if (userId != null) {
      var response = await _userRepository.getUserInfo(id: userId);
      if(response['status']){
        user = response['user'];
        userName = user!.name;
      }//
      else{
        log('error get user.');
      }
    }
    showLoading = false;
    update();
  }
}
