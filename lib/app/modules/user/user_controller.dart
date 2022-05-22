import 'dart:developer';
import 'dart:math' as math;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gosheno/app/data/repository/user_repository.dart';
import 'package:gosheno/app/routes/app_pages.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_sign_in/google_sign_in.dart' as sign_in;

class UserController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final UserRepository userRepository;

  UserController({required this.userRepository});

  TextEditingController signupNameController = TextEditingController();
  TextEditingController signupPhoneController = TextEditingController();
  TextEditingController signupPasswordController = TextEditingController();
  TextEditingController signupRePasswordController = TextEditingController();
  TextEditingController signupCodeController = TextEditingController();
  TextEditingController loginPhoneController = TextEditingController();
  TextEditingController loginPasswordController = TextEditingController();
  late TabController tabController;

  final formKey = GlobalKey<FormState>();
  RxDouble phoneTextFieldHeight = 45.0.obs;
  RxDouble passTextFieldHeight = 45.0.obs;
  RxDouble maxHeight = 275.0.obs;

  @override
  onInit() {
    super.onInit();
    tabController = TabController(length: 2, vsync: this);
    tabController.addListener(() {
      if (tabController.index == 0) {
        maxHeight.value = 275;
      } //
      else {
        maxHeight.value = 360;
      }
    });
    // checkUserLoggedIn();
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
  }

  checkUserLoggedIn() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    bool userLogged = pref.getBool('logging in') ?? false;
    if (userLogged) {
      Get.offNamed(Routes.mainScreen);
    }
  }

  registerUser({
    String userName = '-1',
    String phoneOrEmail = '-1',
    String pass = '-1',
  }) async {
    try {
      String name =
          userName == '-1' ? signupNameController.text.trim() : userName;
      String phoneNumberOrEmail = phoneOrEmail == '-1'
          ? signupPhoneController.text.trim()
          : phoneOrEmail;
      String password =
          pass == '-1' ? signupPasswordController.text.trim() : pass;
      Map<String, dynamic> response = {};
      if (phoneNumberOrEmail.isEmpty || password.isEmpty || name.isEmpty) {
        Get.snackbar('خطا', 'ورودی ها نباید خالی باشد.');
        return;
      } else if (phoneNumberOrEmail.isValidIranianMobileNumber()) {
        response = await userRepository.registerUser(
          name: name,
          pass: password,
          phoneNumber: phoneNumberOrEmail,
          email: '',
        );
      } //
      else if (phoneNumberOrEmail.isEmail) {
        response = await userRepository.registerUser(
          name: name,
          pass: password,
          phoneNumber: '',
          email: phoneNumberOrEmail,
        );
      } //
      else {
        Get.snackbar('خطا', 'اطلاعات وارد شده صحیح نمی باشد.');
        return;
      }
      if (response['status']) {
        SharedPreferences pref = await SharedPreferences.getInstance();
        pref.setInt('userId', response['id']);
        pref.setBool('loggedIn', true);
        pref.setString('userPassword', password);
        Get.snackbar('ثبت نام', 'ثبت نام با موفقیت انجام شد');
        Get.offNamedUntil(
          Routes.mainScreen,
          (route) => false,
        );
      } //
      else {
        int errorCode = response['error'];
        if (errorCode == 110) {
          Get.snackbar('ورود', 'اطلاعات وارد شده صحیح نمی باشد');
        }
      }
    } //
    catch (_) {
      log('no connection **************');
    }
  }

  loginUser({String phoneOrEmail = '-1', String pass = '-1'}) async {
    try {
      String phoneNumberOrEmail = phoneOrEmail == '-1'
          ? loginPhoneController.text.trim()
          : phoneOrEmail;
      String password =
          pass == '-1' ? loginPasswordController.text.trim() : pass;
      Map<String, dynamic> response = {};
      if (formKey.currentState!.validate()) {
        if (phoneNumberOrEmail.isEmail) {
          response = await userRepository.loginUser(
            email: '',
            pass: password,
            phoneNumber: phoneNumberOrEmail,
          );
        } //
        else if (phoneNumberOrEmail.isValidIranianMobileNumber()) {
          response = await userRepository.loginUser(
            email: phoneNumberOrEmail,
            pass: password,
            phoneNumber: '',
          );
        } //
        else {
          Get.snackbar('خطا', 'ایمیل یا شماره تماس وارد شده صحیح نمی باشد.');
          return;
        }
      }
      if (response['status']) {
        SharedPreferences pref = await SharedPreferences.getInstance();
        pref.setInt('userId', response['id']);
        pref.setBool('loggedIn', true);
        pref.setString('userPassword', password);
        Get.snackbar('ورود', 'ورود با موفقیت انجام شد');
        Get.offNamed(Routes.mainScreen);
      } //
      else {
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
      final googleSignIn = sign_in.GoogleSignIn.standard(scopes: [
        'email',
      ]);
      Map<String, String>? authHeaders = {};
      final sign_in.GoogleSignInAccount? account = await googleSignIn.signIn();
      authHeaders = await account?.authHeaders;
      if (authHeaders == null) {
        return null;
      }
      if (login) {
        SharedPreferences pref = await SharedPreferences.getInstance();
        String? pass = pref.getString('userPassword');
        loginUser(phoneOrEmail: account!.email, pass: pass!);
      } //
      else {
        String pass = generatePassword();
        String? userName = account!.displayName;
        if (userName != null) {
          registerUser(
              userName: userName, pass: pass, phoneOrEmail: account.email);
        } //
        else {}
      }
    } catch (e) {
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

  // String? validatePassword(String? value) {
  //   RegExp regExp = RegExp(
  //       r"^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[@#%^*>?=+]).{8,}$");
  //   if (value == null || value.isEmpty) {
  //     height.value = 67;
  //     return 'الزامی، نمی تواند خالی باشد.';
  //   } //
  //   else if (!value.contains(regExp)) {
  //     height.value = 67;
  //     return null;
  //   }
  //   height.value = 45;
  //   return null;
  // }

  sendSms() async {
    String code = generatePassword(isSpecial: false, letter: false, length: 6);
    print(code);
    bool status = await userRepository.sendSms(
        toPhoneNumber: '09100759989', smsCode: code);
    if (status) {}
  }
}
