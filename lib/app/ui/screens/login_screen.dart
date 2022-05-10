import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gosheno/app/routes/app_pages.dart';
import 'package:gosheno/app/ui/theme/app_color.dart';
import 'package:gosheno/app/ui/widgets/circle_button_widget.dart';
import 'package:gosheno/app/ui/widgets/custom_text_field.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Form(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              children: [
                const SizedBox(height: 10),
                Expanded(
                  flex: 3,
                  child: Image.asset(
                    'assets/images/gosheno-logo.png',
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const CustomTextField(
                          labelText: 'موبایل خود را وارد کنید'),
                      const SizedBox(height: 15),
                      const CustomTextField(
                          labelText: 'رمز عبور خود را وارد کنید'),
                      const SizedBox(height: 10),
                      CircleButtonWidget(
                        color: Theme.of(context).colorScheme.secondary,
                        onTap: () {
                          Get.offNamed(Routes.mainScreen);
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
                              Get.toNamed(Routes.signupScreen);
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
                    ],
                  ),
                ),
                const Spacer(
                  flex: 2,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
