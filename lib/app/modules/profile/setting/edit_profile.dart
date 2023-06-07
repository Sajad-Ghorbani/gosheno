import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gosheno/app/core/theme/app_color.dart';
import 'package:gosheno/app/core/theme/app_text_theme.dart';
import 'package:gosheno/app/global_widgets/circle_button_widget.dart';
import 'package:gosheno/app/global_widgets/custom_text_field.dart';
import 'package:gosheno/app/modules/profile/profile_controller.dart';

class EditProfile extends StatelessWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Center(
            child: GetBuilder<ProfileController>(
              builder: (controller) {
                controller.nameController.text = controller.user!.name;
                controller.phoneController.text = controller.user?.mobile ?? '';
                String currentEmail = controller.user?.email ?? '';
                controller.emailController.text = currentEmail;
                return Container(
                  height: MediaQuery.of(context).size.height * 0.8,
                  decoration: const BoxDecoration(
                    color: kWhiteColor,
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        alignment: Alignment.centerLeft,
                        child: GestureDetector(
                          onTap: () {
                            Get.back();
                          },
                          child: const Icon(
                            Icons.close,
                            color: kGreyColor,
                          ),
                        ),
                      ),
                      Expanded(
                        child: ListView(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 40,
                            vertical: 10,
                          ),
                          children: [
                            CustomTextField(
                              height: 45,
                              labelText: 'نام',
                              controller: controller.nameController,
                            ),
                            const SizedBox(height: 10),
                            CustomTextField(
                              height: 45,
                              labelText: 'موبایل',
                              controller: controller.phoneController,
                              keyboardType: TextInputType.phone,
                              enabled: false,
                            ),
                            const SizedBox(height: 10),
                            CustomTextField(
                              height: 45,
                              labelText: 'ایمیل',
                              controller: controller.emailController,
                              keyboardType: TextInputType.emailAddress,
                            ),
                            const SizedBox(height: 10),
                            CustomTextField(
                              height: 45,
                              labelText: 'رمز',
                              controller: controller.passwordController,
                              obscureText: true,
                            ),
                            const SizedBox(height: 10),
                            CustomTextField(
                              height: 45,
                              labelText: 'تکرار رمز',
                              controller: controller.confirmPasswordController,
                              obscureText: true,
                            ),
                            const SizedBox(height: 10),
                            const Text('جنسیت:'),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Radio(
                                  value: 1,
                                  groupValue: controller.selectedGender,
                                  activeColor: kGreenAccentColor,
                                  onChanged: (int? value) {
                                    controller.selectedGender = value!;
                                    controller.update();
                                  },
                                ),
                                const Text('مرد'),
                                const SizedBox(width: 20),
                                Radio(
                                  value: 0,
                                  groupValue: controller.selectedGender,
                                  activeColor: kGreenAccentColor,
                                  onChanged: (int? value) {
                                    controller.selectedGender = value!;
                                    controller.update();
                                  },
                                ),
                                const Text('زن'),
                              ],
                            ),
                            const SizedBox(height: 10),
                            CircleButtonWidget(
                              onTap: () {
                                controller.updateProfile(currentEmail);
                              },
                              color: kGreenAccentColor,
                              height: 45,
                              width: double.infinity,
                              child: Text(
                                'ویرایش',
                                style: kBodyMedium.copyWith(
                                  color: kWhiteColor,
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
