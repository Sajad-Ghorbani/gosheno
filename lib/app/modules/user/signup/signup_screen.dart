import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:gosheno/app/core/theme/app_text_theme.dart';
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
          key: controller.signupFormKey,
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
                    labelText: 'نام و نام خانوادگی',
                    controller: controller.signupNameController,
                    validator: (value) {
                      return controller.validateSignupForm(value, false);
                    },
                    height: controller.nameTextFieldHeight.value,
                  ),
                ),
                const SizedBox(height: 10),
                Obx(
                  () => CustomTextField(
                    labelText: 'موبایل خود را وارد کنید',
                    controller: controller.signupPhoneController,
                    validator: (value) {
                      return controller.validateSignupForm(value, true);
                    },
                    height: controller.phoneSignupTextFieldHeight.value,
                  ),
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  labelText: 'رمز عبور خود را وارد کنید',
                  controller: controller.signupPasswordController,
                  onChanged: (value) {
                    controller.checkPassword(value);
                  },
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  labelText: 'تکرار رمز عبور',
                  controller: controller.signupRePasswordController,
                  onChanged: (value) {
                    controller.checkRePassword(value);
                  },
                ),
                const SizedBox(height: 10),
                Obx(
                  () => Row(
                    children: [
                      Icon(
                        FeatherIcons.checkCircle,
                        size: 14,
                        color: controller.minCharacter.value
                            ? kLightGreenColor
                            : kRedColor,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        'بیشتر از 8 کاراکتر',
                        style: kSubTitle.copyWith(
                          color: controller.minCharacter.value
                              ? kLightGreenColor
                              : kRedColor,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Obx(
                  () => Row(
                    children: [
                      Icon(
                        FeatherIcons.checkCircle,
                        size: 14,
                        color: controller.mixUpperLowerCase.value
                            ? kLightGreenColor
                            : kRedColor,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        'حروف بزرگ و کوچک',
                        style: kSubTitle.copyWith(
                          color: controller.mixUpperLowerCase.value
                              ? kLightGreenColor
                              : kRedColor,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Obx(
                  () => Row(
                    children: [
                      Icon(
                        FeatherIcons.checkCircle,
                        size: 14,
                        color: controller.minNumber.value
                            ? kLightGreenColor
                            : kRedColor,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        'دارای حداقل یک عدد',
                        style: kSubTitle.copyWith(
                          color: controller.minNumber.value
                              ? kLightGreenColor
                              : kRedColor,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Obx(
                  () => Row(
                    children: [
                      Icon(
                        FeatherIcons.checkCircle,
                        size: 14,
                        color: controller.minSpecial.value
                            ? kLightGreenColor
                            : kRedColor,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        'دارای حداقل یک علامت خاص',
                        style: kSubTitle.copyWith(
                          color: controller.minSpecial.value
                              ? kLightGreenColor
                              : kRedColor,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Obx(
                  () => Row(
                    children: [
                      Icon(
                        FeatherIcons.checkCircle,
                        size: 14,
                        color: controller.matchPassword.value
                            ? kLightGreenColor
                            : kRedColor,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        'یکسانی رمز عبور',
                        style: kSubTitle.copyWith(
                          color: controller.matchPassword.value
                              ? kLightGreenColor
                              : kRedColor,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Obx(
                  () => CircleButtonWidget(
                    color: controller.activeButton.value
                        ? Theme.of(context).colorScheme.secondary
                        : Theme.of(context)
                            .colorScheme
                            .secondary
                            .withOpacity(0.6),
                    onTap: () {
                      if (controller.activeButton.value) {
                        controller.sendSms(false, context);
                      }
                    },
                    height: 45,
                    width: double.infinity,
                    child: Text(
                      'ارسال کد',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onSecondary,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
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
                        controller.googleSignIn(true);
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
                          FittedBox(
                            child: Text(
                              'ورود با گوگل',
                              style: TextStyle(
                                color:
                                    Theme.of(context).colorScheme.onSecondary,
                              ),
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
