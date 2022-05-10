import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gosheno/app/routes/app_pages.dart';
import 'package:gosheno/app/ui/widgets/custom_text_field.dart';

import '../theme/app_color.dart';
import '../widgets/circle_button_widget.dart';

class SignupScreen extends StatelessWidget {
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
                const SizedBox(
                  height: 10,
                ),
                Image.asset(
                  'assets/images/gosheno-logo.png',
                  height: Get.height * 0.3,
                ),
                const SizedBox(height: 10),
                const CustomTextField(labelText: 'نام و نام خانوادگی'),
                const SizedBox(height: 10),
                const CustomTextField(labelText: 'موبایل خود را وارد کنید'),
                const SizedBox(height: 10),
                const CustomTextField(labelText: 'رمز عبور خود را وارد کنید'),
                const SizedBox(height: 10),
                const CustomTextField(labelText: 'کد ارسال شده را وارد کنید'),
                const SizedBox(height: 10),
                CircleButtonWidget(
                  color: Theme.of(context).colorScheme.secondary,
                  onTap: () {
                    Get.offNamedUntil(
                      Routes.mainScreen,
                      (route) => false,
                    );
                  },
                  height: 45,
                  width: double.infinity,
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
                      onTap: () {},
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
                const SizedBox(
                  height: 10,
                ),
                const Text('عضو گوشنو هستید؟'),
                const SizedBox(
                  height: 10,
                ),
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
                            'assets/images/gosheno-logo.png',
                            color: kWhiteColor,
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
                      onTap: () {},
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
                              color: Theme.of(context).colorScheme.onSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
