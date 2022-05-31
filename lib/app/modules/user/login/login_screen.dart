import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gosheno/app/modules/user/user_controller.dart';
import 'package:gosheno/app/core/theme/app_color.dart';
import 'package:gosheno/app/global_widgets/circle_button_widget.dart';
import 'package:gosheno/app/global_widgets/custom_text_field.dart';

class LoginScreen extends GetView<UserController> {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: controller.loginFormKey,
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              children: [
                const SizedBox(height: 10),
                Image.asset(
                  'assets/images/gosheno-logo4.png',
                  height: Get.height * 0.3,
                ),
                const SizedBox(height: 10),
                Obx(
                  () => CustomTextField(
                    labelText: 'موبایل یا ایمیل خود را وارد کنید',
                    controller: controller.loginPhoneController,
                    validator: (value){
                      return controller.validateLoginForm(value,false);
                    },
                    height: controller.phoneTextFieldHeight.value,
                  ),
                ),
                const SizedBox(height: 15),
                Obx(
                  () => CustomTextField(
                    labelText: 'رمز عبور خود را وارد کنید',
                    controller: controller.loginPasswordController,
                    validator: (value){
                      return controller.validateLoginForm(value,true);
                    },
                    height: controller.passTextFieldHeight.value,
                  ),
                ),
                const SizedBox(height: 10),
                CircleButtonWidget(
                  color: Theme.of(context).colorScheme.secondary,
                  onTap: () {
                    controller.loginUser();
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
                                color:
                                    Theme.of(context).colorScheme.onSecondary,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    CircleButtonWidget(
                      color: kDarkBlueColor,
                      onTap: () {
                        controller.googleSignIn(false);
                      },
                      height: 35,
                      width: Get.width * 0.35,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Image.asset(
                            'assets/images/google_icon.png',
                            width: 20,
                            color: kWhiteColor,
                          ),
                          Text(
                            'ثبت نام با گوگل',
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.onSecondary,
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
  }
}
