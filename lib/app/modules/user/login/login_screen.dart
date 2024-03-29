import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gosheno/app/global_widgets/custom_button_widget.dart';
import 'package:gosheno/app/global_widgets/loading.dart';
import 'package:gosheno/app/modules/user/user_controller.dart';
import 'package:gosheno/app/core/theme/app_color.dart';
import 'package:gosheno/app/global_widgets/circle_button_widget.dart';
import 'package:gosheno/app/global_widgets/custom_text_field.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/bi.dart';
import 'package:iconify_flutter/icons/ph.dart';
import 'package:iconify_flutter/icons/ri.dart';

class LoginScreen extends GetView<UserController> {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<UserController>(
        builder: (_) {
          return LoadingWidget(
            isLoading: controller.showLoading,
            child: SafeArea(
              child: Form(
                key: controller.loginFormKey,
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Column(
                    children: [
                      const SizedBox(height: 10),
                      Hero(
                        tag: 'logo',
                        child: Image.asset(
                          'assets/images/gosheno-logo4.png',
                          height: Get.height * 0.3,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Obx(
                        () => CustomTextField(
                          labelText: 'موبایل خود را وارد کنید',
                          controller: controller.loginPhoneController,
                          keyboardType: TextInputType.phone,
                          validator: (value) {
                            return controller.validateLoginForm(value, false);
                          },
                          height: controller.phoneTextFieldHeight.value,
                          prefixIcon: const Padding(
                            padding: EdgeInsets.all(10),
                            child: Iconify(
                              Ri.smartphone_line,
                              color: kGreyColor,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                      Obx(
                        () => CustomTextField(
                          labelText: 'رمز عبور خود را وارد کنید',
                          controller: controller.loginPasswordController,
                          validator: (value) {
                            return controller.validateLoginForm(value, true);
                          },
                          height: controller.passTextFieldHeight.value,
                          obscureText: controller.showLoginPass.value,
                          suffixIcon: IconButton(
                            onPressed: () {
                              controller.showLoginPass.value =
                                  !controller.showLoginPass.value;
                            },
                            icon: controller.showLoginPass.value
                                ? const Iconify(
                                    Ph.eye_bold,
                                    color: kGreyColor,
                                  )
                                : const Iconify(
                                    Ph.eye_closed_bold,
                                    color: kGreyColor,
                                  ),
                            splashRadius: 0.1,
                          ),
                          prefixIcon: const Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Iconify(
                              Ph.password_bold,
                              color: kGreyColor,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      CircleButtonWidget(
                        color: Theme.of(context).colorScheme.secondary,
                        onTap: () {
                          controller.loginUser(context);
                        },
                        height: 45,
                        width: double.infinity,
                        child: Text(
                          'ورود به پنل کاربری',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onSecondary,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      InkWell(
                        onTap: () {
                          Get.defaultDialog(
                            title: 'فراموشی رمز عبور',
                            content: CustomTextField(
                              labelText: 'موبایل خود را وارد کنید',
                              controller: controller.forgotPasswordController,
                              height: 45,
                              keyboardType: TextInputType.number,
                            ),
                            contentPadding: const EdgeInsets.symmetric(horizontal: 30,vertical: 20),
                            confirm: CustomButtonWidget(
                              onTap: () {
                                controller.forgotPassword(context);
                              },
                              color: kGreenAccentColor,
                              child: const Text(
                                'ارسال',
                                style: TextStyle(
                                  color: kWhiteColor,
                                ),
                              ),
                            ),
                          );
                        },
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20)),
                        child: const Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          child: Text(
                            'رمز عبور خود را فراموش کرده اید؟',
                            style: TextStyle(
                              color: kGreyColor,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                      const Divider(
                        thickness: 1.2,
                        height: 30,
                        indent: 10,
                        endIndent: 10,
                      ),
                      const SizedBox(height: 10),
                      const Text('عضو گوشنو نیستید؟'),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          CircleButtonWidget(
                            color: Theme.of(context).colorScheme.primary,
                            onTap: () {
                              controller.navigateToSignupScreen(context);
                            },
                            height: 35,
                            width: Get.width * 0.35,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Image.asset(
                                  'assets/images/gosheno-logo3.png',
                                  // color: kWhiteColor,
                                  height: 20,
                                ),
                                FittedBox(
                                  child: Text(
                                    'ایجاد حساب',
                                    style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSecondary,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          CircleButtonWidget(
                            color: kDarkBlueColor,
                            onTap: () {
                              controller.googleSignIn(context);
                            },
                            height: 35,
                            width: Get.width * 0.35,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                const Iconify(
                                  Bi.google,
                                  size: 16,
                                  color: kWhiteColor,
                                ),
                                Text(
                                  'ورود با گوگل',
                                  style: TextStyle(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSecondary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
