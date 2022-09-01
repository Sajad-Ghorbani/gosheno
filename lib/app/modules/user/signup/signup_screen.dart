import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gosheno/app/core/theme/app_text_theme.dart';
import 'package:gosheno/app/global_widgets/loading.dart';
import 'package:gosheno/app/modules/user/user_controller.dart';

import 'package:gosheno/app/global_widgets/custom_text_field.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/bi.dart';
import 'package:iconify_flutter/icons/fluent.dart';
import 'package:iconify_flutter/icons/ph.dart';
import 'package:iconify_flutter/icons/ri.dart';

import '../../../core/theme/app_color.dart';
import '../../../global_widgets/circle_button_widget.dart';

class SignupScreen extends GetView<UserController> {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<UserController>(builder: (_) {
        return LoadingWidget(
          isLoading: controller.showLoading,
          child: SafeArea(
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
                        prefixIcon: const Padding(
                          padding: EdgeInsets.all(10),
                          child: Iconify(
                            Fluent.person_32_regular,
                            color: kGreyColor,
                          ),
                        ),
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
                        keyboardType: TextInputType.phone,
                        height: controller.phoneSignupTextFieldHeight.value,
                        prefixIcon: const Padding(
                          padding: EdgeInsets.all(10),
                          child: Iconify(
                            Ri.smartphone_line,
                            color: kGreyColor,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Obx(
                      () => CustomTextField(
                        labelText: 'رمز عبور خود را وارد کنید',
                        controller: controller.signupPasswordController,
                        onChanged: (value) {
                          controller.checkPassword(value);
                        },
                        obscureText: controller.showSignupPass.value,
                        suffixIcon: IconButton(
                          onPressed: () {
                            controller.showSignupPass.value =
                                !controller.showSignupPass.value;
                          },
                          icon: controller.showSignupPass.value
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
                        toolbarOptions: const ToolbarOptions(
                          copy: false,
                          cut: false,
                          paste: false,
                          selectAll: false,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Obx(
                      () => CustomTextField(
                        labelText: 'تکرار رمز عبور',
                        controller: controller.signupRePasswordController,
                        onChanged: (value) {
                          controller.checkRePassword(value);
                        },
                        obscureText: controller.showSignupRePass.value,
                        suffixIcon: IconButton(
                          onPressed: () {
                            controller.showSignupRePass.value =
                                !controller.showSignupRePass.value;
                          },
                          icon: controller.showSignupRePass.value
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
                        toolbarOptions: const ToolbarOptions(
                          copy: false,
                          cut: false,
                          paste: false,
                          selectAll: false,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Obx(
                      () => Row(
                        children: [
                          Iconify(
                            Bi.check2_circle,
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
                          Iconify(
                            Bi.check2_circle,
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
                          Iconify(
                            Bi.check2_circle,
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
                          Iconify(
                            Bi.check2_circle,
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
                          Iconify(
                            Bi.check2_circle,
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
                              FittedBox(
                                child: Text(
                                  'ورود با گوگل',
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
                      ],
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
