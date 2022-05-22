import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gosheno/app/modules/user/user_controller.dart';

import 'package:gosheno/app/global_widgets/custom_text_field.dart';

import '../../../core/theme/app_color.dart';
import '../../../global_widgets/circle_button_widget.dart';

class SignupScreen extends GetView<UserController> {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
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
                CustomTextField(
                  labelText: 'نام و نام خانوادگی',
                  controller: controller.signupNameController,
                  validator: (value) {
                    // controller.validateFormField(value);
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  labelText: 'موبایل خود را وارد کنید',
                  controller: controller.signupPhoneController,
                  validator: (value) {
                    // controller.validateFormField(value);
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  labelText: 'رمز عبور خود را وارد کنید',
                  controller: controller.signupPasswordController,
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  labelText: 'تکرار رمز عبور',
                  controller: controller.signupRePasswordController,
                ),
                // const SizedBox(height: 10),
                // CustomTextField(
                //   labelText: 'کد ارسال شده را وارد کنید',
                //   controller: controller.signupCodeController,
                // ),
                const SizedBox(height: 10),
                CircleButtonWidget(
                  color: Theme.of(context).colorScheme.secondary,
                  onTap: () {
                    controller.registerUser();
                  },
                  height: 45,
                  width: 120,
                  child: Text(
                    'عضویت در گوشنو',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onSecondary,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        controller.sendSms();
                      },
                      child: const Text('ارسال مجدد کد'),
                    ),
                    Container(
                      decoration: const BoxDecoration(
                        border: Border.symmetric(vertical: BorderSide()),
                      ),
                      width: 1,
                      height: 20,
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                    ),
                    const Text('60 ثانیه')
                  ],
                ),
                const Divider(
                  thickness: 1.2,
                  height: 30,
                  indent: 10,
                  endIndent: 10,
                ),
                const SizedBox(height: 10),
                const Text('عضو گوشنو هستید؟'),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CircleButtonWidget(
                      color: Theme.of(context).colorScheme.primary,
                      onTap: () {
                        Get.back();
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
                              'ورود به حساب',
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
                            'ورود با گوگل',
                            style: TextStyle(
                              color:
                              Theme.of(context).colorScheme.onSecondary,
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
