import 'dart:async';
import 'dart:developer';
import 'dart:math' as math;

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:gosheno/app/core/theme/app_color.dart';
import 'package:gosheno/app/core/utils/app_constants.dart';
import 'package:gosheno/app/data/repository/book_repository.dart';
import 'package:gosheno/app/data/repository/user_repository.dart';
import 'package:gosheno/app/global_widgets/custom_button_widget.dart';
import 'package:gosheno/app/global_widgets/custom_text_field.dart';
import 'package:gosheno/app/routes/app_pages.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_sign_in/google_sign_in.dart' as sign_in;

class UserController extends GetxController {
  final UserRepository userRepository;
  final BookRepository bookRepository;

  UserController({required this.bookRepository, required this.userRepository});

  TextEditingController signupNameController = TextEditingController();
  TextEditingController signupPhoneController = TextEditingController();
  TextEditingController signupPasswordController = TextEditingController();
  TextEditingController signupRePasswordController = TextEditingController();
  TextEditingController signupCodeController = TextEditingController();
  TextEditingController loginPhoneController = TextEditingController();
  TextEditingController loginPasswordController = TextEditingController();
  TextEditingController forgotPasswordController = TextEditingController();
  TextEditingController confirmCodeController = TextEditingController();

  late Timer timer;

  final loginFormKey = GlobalKey<FormState>();
  final signupFormKey = GlobalKey<FormState>();
  RxDouble phoneTextFieldHeight = 45.0.obs;
  RxDouble passTextFieldHeight = 45.0.obs;
  RxDouble nameTextFieldHeight = 45.0.obs;
  RxDouble phoneSignupTextFieldHeight = 45.0.obs;
  RxBool minCharacter = false.obs;
  RxBool mixUpperLowerCase = false.obs;
  RxBool minNumber = false.obs;
  RxBool minSpecial = false.obs;
  RxBool matchPassword = false.obs;
  RxBool activeButton = false.obs;
  RxInt resendTime = 60.obs;
  bool showLoading = false;
  RxBool showLoginPass = true.obs;
  RxBool showSignupPass = false.obs;
  RxBool showSignupRePass = false.obs;

  String verifyCode = '-1';

  final RxString _connectionStatus = '-1'.obs;
  final Rx<Connectivity> _connectivity = Connectivity().obs;
  Rx<ConnectivityResult> result = ConnectivityResult.none.obs;

  @override
  void onInit() {
    super.onInit();
    timer = Timer(const Duration(), () {});
    initConnectivity();
    ever(result, (_) {
      _connectivity.value.onConnectivityChanged.listen(_updateConnectionStatus);
    });
  }

  @override
  onClose() {
    super.onClose();
    result.close();
    _connectivity.close();
    signupNameController.dispose();
    signupPhoneController.dispose();
    signupPasswordController.dispose();
    signupRePasswordController.dispose();
    signupCodeController.dispose();
    loginPhoneController.dispose();
    loginPasswordController.dispose();
    timer.cancel();
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    switch (result) {
      case ConnectivityResult.wifi:
        _connectionStatus.value = 'wifi net';
        break;
      case ConnectivityResult.mobile:
        _connectionStatus.value = 'mobile net';
        break;
      case ConnectivityResult.none:
        _connectionStatus.value = '-1';
        Get.snackbar(
          'اینترنت متصل نمی باشد.',
          'لطفا داده ها یا wifi را روشن کنید.',
          snackStyle: SnackStyle.FLOATING,
          snackPosition: SnackPosition.TOP,
        );
        break;
      default:
        _connectionStatus.value = 'Failed to get connectivity.';
        break;
    }
    if (_connectionStatus.value != '-1') {
      Future.delayed(const Duration(seconds: 5), () async {
        checkUserLoggedIn();
      });
    }
  }

  Future<void> initConnectivity() async {
    try {
      result.value = await _connectivity.value.checkConnectivity();
    } on PlatformException catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }

    return _updateConnectionStatus(result.value);
  }

  checkUserLoggedIn() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    bool userLogged = pref.getBool(AppConstants.loggedInKey) ?? false;
    if (userLogged) {
      Get.offNamed(Routes.mainScreen);
    } //
    else {
      Get.offNamed(Routes.loginScreen);
    }
  }

  registerUser(
    context, {
    String userName = '-1',
    String email = '-1',
    String pass = '-1',
  }) async {
    FocusScope.of(context).unfocus();
    try {
      String name =
          userName == '-1' ? signupNameController.text.trim() : userName;
      String phoneNumberOrEmail =
          email == '-1' ? signupPhoneController.text.trim() : email;
      String password =
          pass == '-1' ? signupPasswordController.text.trim() : pass;
      Map<String, dynamic> response = {};
      if (userName == '-1') {
        if (verifyCode != signupCodeController.text.trim()) {
          Get.snackbar('خطا', 'کد وارد شده صحیح نمی باشد.');
          return;
        }
      }
      if (phoneNumberOrEmail.isValidIranianMobileNumber()) {
        showLoading = true;
        update();
        response = await userRepository.registerUser(
          name: name,
          pass: password,
          phoneNumber: phoneNumberOrEmail,
        );
      } //
      else if (phoneNumberOrEmail.isEmail) {
        showLoading = true;
        update();
        response = await userRepository.registerUser(
          name: name,
          pass: password,
          email: phoneNumberOrEmail,
        );
      } //
      else {
        showLoading = false;
        update();
        Get.snackbar('خطا', 'اطلاعات وارد شده صحیح نمی باشد.');
        return;
      }
      if (response['status']) {
        SharedPreferences pref = await SharedPreferences.getInstance();
        pref.setInt(AppConstants.userIdKey, response['user'].id);
        pref.setBool(AppConstants.loggedInKey, true);
        showLoading = false;
        update();
        Get.snackbar('ثبت نام', 'ثبت نام با موفقیت انجام شد');
        Get.offNamedUntil(
          Routes.mainScreen,
          (route) => false,
        );
      } //
      else {
        showLoading = false;
        update();
        Get.snackbar('ثبت نام', response['error'][0]);
      }
    } //
    catch (_) {
      showLoading = false;
      update();
      log('no connection **************');
    }
  }

  loginUser(context) async {
    try {
      String phoneNumber = loginPhoneController.text.trim();
      String password = loginPasswordController.text.trim();
      Map<String, dynamic> response = {};
      FocusScope.of(context).unfocus();
      if (!loginFormKey.currentState!.validate()) {
        return;
      }
      showLoading = true;
      update();
      response = await userRepository.loginUser(
        phoneNumber: phoneNumber,
        pass: password,
      );
      if (response['status']) {
        SharedPreferences pref = await SharedPreferences.getInstance();
        pref.setInt(AppConstants.userIdKey, response['user'].id);
        pref.setBool(AppConstants.loggedInKey, true);
        Get.snackbar('ورود', 'ورود با موفقیت انجام شد');
        showLoading = false;
        loginPhoneController.clear();
        loginPasswordController.clear();
        update();
        Get.offAllNamed(Routes.mainScreen);
      } //
      else {
        showLoading = false;
        update();
        Get.snackbar('ورود', response['error']);
      }
    } //
    catch (_) {
      showLoading = false;
      update();
      log(_.toString());
    }
  }

  googleSignIn(context) async {
    try {
      showLoading = true;
      update();
      final googleSignIn = sign_in.GoogleSignIn.standard(scopes: [
        'email',
      ]);
      Map<String, String>? authHeaders = {};
      final sign_in.GoogleSignInAccount? account = await googleSignIn.signIn();
      authHeaders = await account?.authHeaders;
      if (authHeaders == null) {
        showLoading = false;
        update();
        return null;
      }
      final Map<String, dynamic> response =
          await userRepository.checkUserEmailExist(email: account!.email);
      if (response['status']) {
        SharedPreferences pref = await SharedPreferences.getInstance();
        pref.setInt(AppConstants.userIdKey, response['id']);
        pref.setBool(AppConstants.loggedInKey, true);
        showLoading = false;
        loginPhoneController.clear();
        loginPasswordController.clear();
        update();
        Get.snackbar('ورود', 'ورود با موفقیت انجام شد');
        Get.offAllNamed(Routes.mainScreen);
      } //
      else {
        String pass = generatePassword();
        String userName = account.displayName ?? account.email;
        registerUser(
          context,
          userName: userName,
          email: account.email,
          pass: pass,
        );
      }
    } catch (e) {
      showLoading = false;
      update();
      log(e.toString());
      return null;
    }
  }

  String generatePassword({
    bool letter = true,
    bool isNumber = true,
    bool isSpecial = true,
    int length = 20,
  }) {
    const letterLowerCase = "abcdefghijklmnopqrstuvwxyz";
    const letterUpperCase = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    const number = '0123456789';
    const special = '@#%^*>?=+';

    String chars = "";
    if (letter) chars += '$letterLowerCase$letterUpperCase';
    if (isNumber) chars += number;
    if (isSpecial) chars += special;

    return List.generate(length, (index) {
      final indexRandom = math.Random.secure().nextInt(chars.length);
      return chars[indexRandom];
    }).join('');
  }

  String? validateLoginForm(String? value, bool isPass) {
    if (isPass) {
      if (value == null || value.isEmpty) {
        passTextFieldHeight.value = 67;
        return 'الزامی، نمی تواند خالی باشد.';
      }
      passTextFieldHeight.value = 45;
      return null;
    } //
    else {
      if (value == null || value.isEmpty) {
        phoneTextFieldHeight.value = 67;
        return 'الزامی، نمی تواند خالی باشد.';
      } //
      else if (!value.isValidIranianMobileNumber()) {
        phoneTextFieldHeight.value = 67;
        return 'شماره تماس وارد شده صحیح نمی باشد.';
      }
      phoneTextFieldHeight.value = 45;
      return null;
    }
  }

  String? validateSignupForm(String? value, bool isPhone) {
    if (isPhone) {
      if (value == null || value.isEmpty) {
        phoneSignupTextFieldHeight.value = 67;
        return 'الزامی، نمی تواند خالی باشد.';
      } //
      else if (!value.isValidIranianMobileNumber()) {
        phoneSignupTextFieldHeight.value = 67;
        return 'شماره تلفن وارد شده صحیح نمی باشد.';
      }
      phoneSignupTextFieldHeight.value = 45;
      return null;
    } //
    else {
      if (value == null || value.isEmpty) {
        nameTextFieldHeight.value = 67;
        return 'الزامی، نمی تواند خالی باشد.';
      }
      nameTextFieldHeight.value = 45;
      return null;
    }
  }

  sendSms(bool isResend, context) async {
    FocusScope.of(context).unfocus();
    if (signupFormKey.currentState!.validate() && activeButton.value) {
      showLoading = true;
      update();
      startTimer();
      verifyCode = generatePassword(isSpecial: false, letter: false, length: 6);
      bool status = await userRepository.sendSms(
          toPhoneNumber: signupPhoneController.text.trim(),
          smsCode: verifyCode);
      if (status) {
        showLoading = false;
        update();
        Get.snackbar('ارسال کد', 'کد تایید با موفقیت ارسال شد.');
        if (!isResend) {
          Get.toNamed(Routes.verifyPhoneScreen);
        }
      } //
      else {
        showLoading = false;
        update();
        Get.snackbar('خطا', 'خطایی رخ داده است، لطفا دوباره تلاش کنید.');
      }
    }
  }

  void navigateToSignupScreen(context) {
    loginPhoneController.clear();
    loginPasswordController.clear();
    FocusScope.of(context).unfocus();
    Get.toNamed(Routes.signupScreen);
  }

  bool checkPassword(String pass) {
    if (pass.length > 8) {
      minCharacter.value = true;
    } //
    else {
      minCharacter.value = false;
    }
    if (pass.contains(RegExp(r'[A-Z]')) && pass.contains(RegExp(r'[a-z]'))) {
      mixUpperLowerCase.value = true;
    } //
    else {
      mixUpperLowerCase.value = false;
    }
    if (pass.contains(RegExp(r'[0-9]'))) {
      minNumber.value = true;
    } //
    else {
      minNumber.value = false;
    }
    if (pass.contains(RegExp(r'[@#%^*>?=+]'))) {
      minSpecial.value = true;
    } //
    else {
      minSpecial.value = false;
    }
    if (minCharacter.value &&
        minNumber.value &&
        minSpecial.value &&
        mixUpperLowerCase.value) {
      return true;
    } //
    else {
      return false;
    }
  }

  void checkRePassword(String rePass) {
    if (checkPassword(signupPasswordController.text)) {
      if (rePass.isEmpty) {
        matchPassword.value = false;
        activeButton.value = false;
      } else if (rePass == signupPasswordController.text) {
        matchPassword.value = true;
        activeButton.value = true;
      } //
      else {
        matchPassword.value = false;
        activeButton.value = false;
      }
    } //
    else {
      matchPassword.value = false;
      activeButton.value = false;
    }
  }

  startTimer() {
    const oneSec = Duration(seconds: 1);
    timer = Timer.periodic(oneSec, (timer) {
      if (resendTime.value == 0) {
        timer.cancel();
        resendTime.value = 60;
      } //
      else {
        resendTime.value--;
      }
    });
  }

  void forgotPassword(BuildContext context) async {
    String phone = forgotPasswordController.text.trim();
    FocusScope.of(context).unfocus();
    Get.back();
    showLoading = true;
    update();
    var response = await userRepository.resetPassword(
      phoneNumber: phone,
    );
    if (response['status']) {
      showLoading = false;
      update();
      startTimer();
      Get.defaultDialog(
        title: 'کد فعالسازی',
        content: Column(
          children: [
            const Text(
              'کد فعالسازی به شماره تلفن شما ارسال شد.',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            CustomTextField(
              labelText: 'کد را وارد کنید.',
              controller: confirmCodeController,
              height: 45,
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    resendTime.value == 60 ? resendCode(phone) : null;
                  },
                  child: Obx(
                    () => Text(
                      'ارسال مجدد کد',
                      style: TextStyle(
                        color:
                            resendTime.value == 60 ? kBlackColor : kGreyColor,
                      ),
                    ),
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(
                    border: Border.symmetric(vertical: BorderSide()),
                  ),
                  width: 1,
                  height: 20,
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                ),
                Obx(
                  () => SizedBox(
                    width: 25,
                    child: Text('${resendTime.value}'),
                  ),
                ),
                const Text('ثانیه'),
              ],
            ),
          ],
        ),
        confirm: CustomButtonWidget(
          onTap: () {
            confirmPassword(phone, response['code'], context);
          },
          color: kGreenAccentColor,
          child: const Text('تایید'),
        ),
      );
    } //
    else {
      showLoading = false;
      update();
      Get.snackbar('خطا', 'خطایی رخ داده است، لطفا دوباره تلاش کنید.');
    }
  }

  void confirmPassword(
      String phoneNumber, int token, BuildContext context) async {
    if (confirmCodeController.text.isEmpty) {
      Get.snackbar('خطا', 'کد تایید را وارد کنید.');
    } //
    else if (int.parse(confirmCodeController.text) != token) {
      Get.snackbar('خطا', 'کد وارد شده صحیح نمی باشد.');
    } else {
      FocusScope.of(context).unfocus();
      Get.back();
      showLoading = true;
      update();
      var response = await userRepository.confirmPassword(
        phoneNumber: phoneNumber,
      );
      if (response['status']) {
        showLoading = false;
        update();
        Get.snackbar('رمز جدید', 'رمز عبور جدید برای شما ارسال شد.');
      } //
      else {
        Get.snackbar('خطا', 'خطایی رخ داده است، لطفا دوباره تلاش کنید.');
      }
    }
  }

  resendCode(String phone) async {
    startTimer();
    var response = await userRepository.resetPassword(
      phoneNumber: phone,
    );
    if (response['status']) {
      Get.snackbar('کد فعالسازی', 'کد فعالسازی برای شما ارسال شد.');
    } //
    else {
      Get.snackbar('خطا', 'خطایی رخ داده است، لطفا دوباره تلاش کنید.');
    }
  }
}
