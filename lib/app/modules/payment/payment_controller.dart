import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gosheno/app/core/theme/app_color.dart';
import 'package:gosheno/app/core/utils/app_constants.dart';
import 'package:gosheno/app/core/utils/constants_methods.dart';
import 'package:gosheno/app/data/models/book_model.dart';
import 'package:gosheno/app/data/models/coupon_model.dart';
import 'package:gosheno/app/data/repository/book_repository.dart';
import 'package:gosheno/app/data/repository/user_repository.dart';
import 'package:gosheno/app/modules/cart/cart_controller.dart';
import 'package:gosheno/app/routes/app_pages.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uni_links/uni_links.dart';
import 'package:url_launcher/url_launcher.dart';

class PaymentController extends GetxController {
  final UserRepository _userRepository;
  final BookRepository _bookRepository;

  PaymentController(this._userRepository, this._bookRepository);

  TextEditingController offCountController = TextEditingController();
  bool isLoading = false;
  List<Coupon> couponList = [];
  List<Book> books = Get.find<CartController>().books;
  int totalCartPrice = Get.find<CartController>().totalCartPrice;
  int totalPrice = Get.find<CartController>().totalCartPrice;

  @override
  void onInit() {
    super.onInit();
    _handleIncomingLinks();
  }

  void applyOff(context) async {
    FocusScope.of(context).unfocus();
    isLoading = true;
    update();
    try {
      var response = await _userRepository.getCoupons();
      if (response['status']) {
        couponList = response['coupons'];
        Coupon? coupon = couponList
            .firstWhereOrNull((item) => item.name == offCountController.text);
        if (coupon != null) {
          totalPrice =
              totalCartPrice - (int.parse(coupon.val) * totalPrice ~/ 100);
          isLoading = false;
          update();
        } //
        else {
          isLoading = false;
          update();
          ConstantsMethods.showToast(
              'کد تخفیف وارد شده صحیح نمی باشد', kRedColor);
        }
      } //
      else {
        isLoading = false;
        update();
        ConstantsMethods.showToast(
            'کد تخفیف وارد شده صحیح نمی باشد', kRedColor);
      }
      isLoading = false;
      update();
    } //
    on Exception catch (e) {
      isLoading = false;
      update();
      log('error get coupons: $e');
    }
  }

  checkout() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    int userId = pref.getInt(AppConstants.userIdKey) ?? 0;
    List<int> bookIds = [];
    for (var item in books) {
      bookIds.add(item.id);
    }
    await launchUrl(
      Uri.parse(
          'https://gosheno.com/api/v1/payment/buy?uid=$userId&amount=$totalPrice&books=$bookIds'),
      mode: LaunchMode.externalApplication,
    );
  }

  void _handleIncomingLinks() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    int userId = pref.getInt(AppConstants.userIdKey) ?? 0;
    uriLinkStream.listen((Uri? uri) async {
      Get.offAllNamed(Routes.mainScreen);
      isLoading = true;
      update();
      var response = await _bookRepository.getMyBooks(id: userId);
      List<Book> responseBooks = response['books'];
      bool isFound = books.every((element) => responseBooks.contains(element));
      if (isFound) {
        pref.setStringList(AppConstants.cartKey, []);
        ConstantsMethods.showToast(
            'خرید با موفقیت انجام شد', kGreenAccentColor);
        isLoading = false;
        update();
      } //
      else {
        ConstantsMethods.showToast('خرید با موفقیت انجام نشد', kRedColor);
        isLoading = false;
        update();
      }
    }, onError: (Object err) {
      log('got err: $err');
    });
  }
}
