import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gosheno/app/core/theme/app_color.dart';
import 'package:gosheno/app/core/theme/app_text_theme.dart';
import 'package:gosheno/app/global_widgets/circle_button_widget.dart';
import 'package:gosheno/app/global_widgets/custom_button_widget.dart';
import 'package:gosheno/app/global_widgets/custom_text_field.dart';
import 'package:gosheno/app/global_widgets/loading.dart';
import 'package:gosheno/app/modules/payment/payment_controller.dart';
import 'package:persian_number_utility/persian_number_utility.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PaymentController>(
      builder: (controller) {
        return LoadingWidget(
          isLoading: controller.isLoading,
          child: Scaffold(
            appBar: AppBar(
              title: const Text('پرداخت'),
              centerTitle: true,
              leading: IconButton(
                splashRadius: 25,
                onPressed: () {
                  Get.back();
                },
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: kWhiteColor,
                ),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: kWhiteColor,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: kBlackColor.withOpacity(0.2),
                          blurRadius: 10,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.all(13),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('مجموع سبد خرید', style: kBodyMedium),
                            Row(
                              children: [
                                Text(
                                  '${controller.totalCartPrice}'.seRagham(),
                                  style: kBodyMedium.copyWith(
                                    color: kGreenAccentColor,
                                  ),
                                ),
                                Text(
                                  ' تومان',
                                  style: kBodyMedium.copyWith(
                                    color: kGreenAccentColor,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: Get.width * 0.6,
                              child: CustomTextField(
                                labelText: 'کد تخفیف دارید؟',
                                controller: controller.offCountController,
                              ),
                            ),
                            CustomButtonWidget(
                              onTap: () {
                                controller.applyOff(context);
                              },
                              color: kBlueGreyColor,
                              child: Text(
                                'اعمال',
                                style: kBodyMedium.copyWith(
                                  color: kWhiteColor,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                      ],
                    ),
                  ),
                  const Spacer(),
                  Container(
                    decoration: BoxDecoration(
                      color: kWhiteColor,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: kBlackColor.withOpacity(0.2),
                          blurRadius: 10,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.all(13),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('مبلغ قابل پرداخت', style: kBodyMedium),
                        Row(
                          children: [
                            Text(
                              '${controller.totalPrice}'.seRagham(),
                              style: kBodyMedium.copyWith(
                                color: kGreenAccentColor,
                              ),
                            ),
                            Text(
                              ' تومان',
                              style: kBodyMedium.copyWith(
                                color: kGreenAccentColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: CircleButtonWidget(
                      onTap: () {
                        controller.checkout();
                      },
                      width: 200,
                      height: 45,
                      color: kGreenAccentColor,
                      child: Text(
                        'پرداخت',
                        style: kBodyMedium.copyWith(
                          fontSize: 20,
                          color: kWhiteColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
