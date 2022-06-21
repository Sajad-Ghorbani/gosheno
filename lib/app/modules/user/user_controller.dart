import 'dart:async';
import 'dart:developer';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gosheno/app/data/repository/user_repository.dart';
import 'package:gosheno/app/routes/app_pages.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_sign_in/google_sign_in.dart' as sign_in;

class UserController extends GetxController {
  final UserRepository userRepository;

  UserController({required this.userRepository});

  TextEditingController signupNameController = TextEditingController();
  TextEditingController signupPhoneController = TextEditingController();
  TextEditingController signupPasswordController = TextEditingController();
  TextEditingController signupRePasswordController = TextEditingController();
  TextEditingController signupCodeController = TextEditingController();
  TextEditingController loginPhoneController = TextEditingController();
  TextEditingController loginPasswordController = TextEditingController();

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

  @override
  onInit() {
    super.onInit();
    timer = Timer(const Duration(), () {});
    checkUserLoggedIn();
  }

  @override
  onClose() {
    super.onClose();
    signupNameController.dispose();
    signupPhoneController.dispose();
    signupPasswordController.dispose();
    signupRePasswordController.dispose();
    signupCodeController.dispose();
    loginPhoneController.dispose();
    loginPasswordController.dispose();
    timer.cancel();
  }

  checkUserLoggedIn() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    bool userLogged = pref.getBool('loggedIn') ?? false;
    if (userLogged) {
      Get.offNamed(Routes.mainScreen);
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
        pref.setInt('userId', response['id']);
        pref.setBool('loggedIn', true);
        pref.setString('userPassword', password);
        showLoading = false;
        update();
        Get.snackbar('ثبت نام', 'ثبت نام با موفقیت انجام شد');
        Get.offNamedUntil(
          Routes.mainScreen,
          (route) => false,
        );
      } //
      else {
        int errorCode = int.parse(response['error']);
        if (errorCode == 110) {
          showLoading = false;
          update();
          Get.snackbar('ثبت نام', 'اطلاعات وارد شده صحیح نمی باشد');
        } //
        else if (errorCode == 111 || errorCode == 106) {
          showLoading = false;
          update();
          Get.snackbar(
              'ثبت نام', 'مشکلی سمت سرور رخ داده، لطفا دوباره امتحان کنید.');
        } //
        else if (errorCode == 114) {
          showLoading = false;
          update();
          Get.snackbar(
              'ثبت نام', 'شما قبلا با این شماره تلفن ثبت نام کرده اید.');
        } //
        else if (errorCode == 115) {
          showLoading = false;
          update();
          Get.snackbar('ثبت نام', 'شما قبلا با این ایمیل ثبت نام کرده اید.');
        } //
        else if (errorCode == 116) {
          showLoading = false;
          update();
          Get.snackbar('ثبت نام', 'شماره تلفن وارد نشده است');
        }
      }
    } //
    catch (_) {
      showLoading = false;
      update();
      log('no connection **************');
    }
  }

  loginUser(context, {String phoneOrEmail = '-1', String pass = '-1'}) async {
    try {
      String phoneNumberOrEmail = phoneOrEmail == '-1'
          ? loginPhoneController.text.trim()
          : phoneOrEmail;
      String password =
          pass == '-1' ? loginPasswordController.text.trim() : pass;
      Map<String, dynamic> response = {};
      FocusScope.of(context).unfocus();
      if (phoneOrEmail == '-1') {
        if (!loginFormKey.currentState!.validate()) {
          return;
        }
      }
      if (phoneNumberOrEmail.isEmail) {
        showLoading = true;
        update();
        response = await userRepository.loginUser(
          email: phoneNumberOrEmail,
          pass: password,
          phoneNumber: '',
        );
      } //
      else if (phoneNumberOrEmail.isValidIranianMobileNumber()) {
        showLoading = true;
        update();
        response = await userRepository.loginUser(
          email: '',
          pass: password,
          phoneNumber: phoneNumberOrEmail,
        );
      } //
      else {
        Get.snackbar('خطا', 'ایمیل یا شماره تماس وارد شده صحیح نمی باشد.');
        return;
      }
      if (response['status']) {
        SharedPreferences pref = await SharedPreferences.getInstance();
        pref.setInt('userId', response['id']);
        pref.setBool('loggedIn', true);
        pref.setString('userPassword', password);
        Get.snackbar('ورود', 'ورود با موفقیت انجام شد');
        showLoading = false;
        update();
        Get.offAllNamed(Routes.mainScreen);
      } //
      else {
        showLoading = false;
        update();
        int errorCode = response['error'];
        if (errorCode == 110) {
          Get.snackbar('ورود', 'اطلاعات وارد شده صحیح نمی باشد');
        }
      }
    } //
    catch (_) {}
  }

  googleSignIn(bool login) async {
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
      if (login) {
        SharedPreferences pref = await SharedPreferences.getInstance();
        String? pass = pref.getString('userPassword');
        loginUser(loginFormKey.currentContext,
            phoneOrEmail: account!.email, pass: pass!);
      } //
      else {
        String pass = generatePassword();
        String? userName = account!.displayName;
        if (userName != null) {
          registerUser(signupFormKey.currentContext,
              userName: userName, pass: pass, email: account.email);
        } //
        else {
          registerUser(signupFormKey.currentContext,
              userName: account.email, pass: pass, email: account.email);
        }
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
    showLoading = true;
    update();
    FocusScope.of(context).unfocus();
    if (signupFormKey.currentState!.validate() && activeButton.value) {
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
}
