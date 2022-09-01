import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:gosheno/app/core/theme/app_color.dart';
import 'package:gosheno/app/core/utils/app_constants.dart';
import 'package:gosheno/app/core/utils/constants_methods.dart';
import 'package:gosheno/app/core/utils/extensions.dart';
import 'package:gosheno/app/data/models/coupon_model.dart';
import 'package:gosheno/app/data/provider/user_api_provider.dart';
import 'package:gosheno/app/data/repository/user_repository.dart';
import 'package:gosheno/app/routes/app_pages.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uni_links/uni_links.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../data/models/user_model.dart';

class ProfileController extends GetxController {
  final UserRepository _userRepository = UserRepository(
    apiClient: UserApiClient(),
  );

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController walletAmountController = TextEditingController();

  User? user;
  String userName = '';
  bool showLoading = true;
  int subscribe = 0;
  String timeReadingTotal = '0';
  String timeReadingDay = '0';
  String timeUnitTotal = '';
  String timeUnitDay = '';
  bool showTotalTime = false;
  List<Coupon> couponList = [];
  int selectedGender = 1;

  @override
  onInit() {
    super.onInit();
    getUserInfo();
    getUserSubscriptions();
    getUserReadingTime();
    getCoupons();
    _handleIncomingLinks();
  }

  @override
  void onClose() {
    super.onClose();
    nameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    walletAmountController.dispose();
  }

  void _handleIncomingLinks() {
    uriLinkStream.listen((Uri? uri) {
      Get.offAllNamed(Routes.mainScreen);
    }, onError: (Object err) {
      log('got err: $err');
    });
  }

  void logout() async {
    Get.offAllNamed(Routes.loginScreen);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  getUserInfo() async {
    showLoading = true;
    update();
    SharedPreferences pref = await SharedPreferences.getInstance();
    int? userId = pref.getInt(AppConstants.userIdKey);
    if (userId != null) {
      var response = await _userRepository.getUserInfo(id: userId);
      if (response['status']) {
        user = response['user'];
        userName = user!.name;
        selectedGender = int.tryParse(user!.sex!) ?? 1;
      } //
      else {
        log('error get user.');
      }
    }
    showLoading = false;
    update();
  }

  void getUserSubscriptions() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    int? userId = pref.getInt(AppConstants.userIdKey);
    if (userId != null) {
      var response = await _userRepository.checkUserSubscribe(id: userId);
      if (response['status']) {
        subscribe = response['subscribe'];
      } //
      else {
        log('error get user.');
      }
    }
    showLoading = false;
    update();
  }

  void getUserReadingTime() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? readingTimeTotal = pref.getString(AppConstants.readingTimeTotalKey);
    String? readingTimeDay = pref.getString(AppConstants.readingTimeDayKey);
    if (readingTimeTotal != null) {
      Duration time = readingTimeTotal.parseDuration();
      if (time < const Duration(seconds: 60)) {
        timeReadingTotal = '${time.inSeconds}';
        timeUnitTotal = '(ثانیه)';
      } //
      else if (time < const Duration(minutes: 60)) {
        timeReadingTotal = '${time.inMinutes}';
        timeUnitTotal = '(دقیقه)';
      } //
      else {
        timeReadingTotal = '${time.inHours}';
        timeUnitTotal = '(ساعت)';
      }
    }
    if (readingTimeDay != null) {
      DateTime day = (readingTimeDay.split('/').last).toDate();
      DateTime now = DateTime.now();
      if (day.day == now.day &&
          day.month == now.month &&
          day.year == now.year) {
        Duration time = (readingTimeDay.split('/').first).parseDuration();
        if (time < const Duration(seconds: 60)) {
          timeReadingDay = '${time.inSeconds}';
          timeUnitDay = '(ثانیه)';
        } //
        else if (time < const Duration(minutes: 60)) {
          timeReadingDay = '${time.inMinutes}';
          timeUnitDay = '(دقیقه)';
        } //
        else {
          timeReadingDay = '${time.inHours}';
          timeUnitDay = '(ساعت)';
        }
      }
    }
    showLoading = false;
    update();
  }

  void getCoupons() async {
    try {
      var response = await _userRepository.getCoupons();
      if (response['status']) {
        couponList = response['coupons'];
      } //
      else {
        log('error get user.');
      }
      update();
    } //
    on Exception catch (e) {
      log('error get coupons: $e');
    }
  }

  void updateProfile() async {
    showLoading = true;
    update();
    String name = nameController.text.trim();
    String phone = phoneController.text.trim();
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    String confirmPassword = confirmPasswordController.text.trim();
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      int userId = pref.getInt(AppConstants.userIdKey) ?? 0;
      if (name.isEmpty || phone.isEmpty) {
        ConstantsMethods.showToast('نام و شماره تلفن را وارد کنید', kRedColor);
        return;
      } //
      else if (!phone.isValidIranianMobileNumber()) {
        ConstantsMethods.showToast(
            'شماره موبایل به درستی وارد نشده است', kRedColor);
        return;
      } //
      else if (password != confirmPassword) {
        ConstantsMethods.showToast(
            'رمز عبور با تکرار آن مطابقت ندارد', kRedColor);
        return;
      } //
      else {
        var response = await _userRepository.editUserInfo(
          id: userId,
          name: name,
          phoneNumber: phone,
          email: email,
          password: password,
          sex: selectedGender,
        );
        if (response['status']) {
          ConstantsMethods.showToast(response['message'], kGreenAccentColor);
          nameController.clear();
          phoneController.clear();
          emailController.clear();
          passwordController.clear();
          confirmPasswordController.clear();
          await getUserInfo();
          Get.back();
        } //
        else {
          ConstantsMethods.showToast(response['message'], kRedColor);
        }
      }
    } //
    catch (e) {
      log('error update profile: $e');
    }
  }

  void copyCoupon(String name) {
    Clipboard.setData(ClipboardData(text: name));
    ConstantsMethods.showToast('کپی شد', kGreenAccentColor);
  }

  void chargeWallet() async {
    String amount = walletAmountController.text.trim();
    if (amount.isEmpty) {
      ConstantsMethods.showToast('مبلغ را وارد کنید', kRedColor);
      return;
    } //
    else if (int.parse(amount) < 10000 || int.parse(amount) > 50000000) {
      ConstantsMethods.showToast('مبلغ به درستی وارد نشده است', kRedColor);
      return;
    } //
    else {
      SharedPreferences pref = await SharedPreferences.getInstance();
      int userId = pref.getInt(AppConstants.userIdKey) ?? 0;
      await launchUrl(
        Uri.parse(
            'https://gosheno.com/api/v1/payment/addfunds?uid=$userId&amount=${int.parse(amount)}'),
        mode: LaunchMode.externalApplication,
      );
      walletAmountController.clear();
      Get.back();
    }
  }

  void buySubscribe(int subMonth) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    int userId = pref.getInt(AppConstants.userIdKey) ?? 0;
    await launchUrl(
      Uri.parse(
          'https://gosheno.com/api/v1/payment/renew?uid=$userId&period=$subMonth'),
      mode: LaunchMode.externalApplication,
    );
  }

  void openGitigetSite() async {
    await launchUrl(
      Uri.parse(
          'https://gitiget.com/%d8%b3%d9%81%d8%a7%d8%b1%d8%b4-%d9%be%d8%b1%d9%88%da%98%d9%87/'),
      mode: LaunchMode.externalApplication,
    );
  }
}
