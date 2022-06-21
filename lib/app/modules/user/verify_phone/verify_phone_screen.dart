import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gosheno/app/global_widgets/circle_button_widget.dart';
import 'package:gosheno/app/global_widgets/custom_text_field.dart';
import 'package:gosheno/app/global_widgets/loading.dart';
import 'package:gosheno/app/modules/user/user_controller.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/fluent.dart';

class VerifyPhoneScreen extends GetView<UserController> {
  const VerifyPhoneScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<UserController>(
        builder: (_) {
          return LoadingWidget(
            isLoading: controller.showLoading,
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomTextField(
                      labelText: 'کد ارسال شده را وارد کنید',
                      controller: controller.signupCodeController,
                      prefixIcon: const Padding(
                        padding: EdgeInsets.all(10),
                        child: Iconify(
                          Fluent.number_symbol_square_24_regular,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    CircleButtonWidget(
                      color: Theme.of(context).colorScheme.secondary,
                      onTap: () {
                        controller.registerUser(context);
                      },
                      height: 45,
                      width: double.infinity,
                      child: Text(
                        'ثبت نام در گوشنو',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onSecondary,
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            controller.resendTime.value == 60
                                ? controller.sendSms(true, context)
                                : null;
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
                        Obx(
                          () => SizedBox(
                            width: 25,
                            child: Text('${controller.resendTime}'),
                          ),
                        ),
                        const Text('ثانیه'),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
