import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gosheno/app/core/theme/app_color.dart';
import 'package:gosheno/app/core/theme/app_text_theme.dart';
import 'package:gosheno/app/global_widgets/circle_button_widget.dart';
import 'package:gosheno/app/global_widgets/loading.dart';
import 'package:gosheno/app/modules/profile/profile_controller.dart';
import 'package:gosheno/app/routes/app_pages.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/fluent.dart';
import 'package:iconify_flutter/icons/fontisto.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
      init: ProfileController(),
      builder: (controller) {
        return LoadingWidget(
          isLoading: controller.showLoading,
          child: Scaffold(
            appBar: AppBar(
              centerTitle: true,
              toolbarHeight: 210,
              title: SizedBox(
                height: 220,
                child: Column(
                  children: [
                    Row(
                      children: [
                        const Expanded(
                          child: Center(
                            child: Text('پروفایل'),
                          ),
                        ),
                        IconButton(
                          icon: const Iconify(
                            Fluent.settings_32_regular,
                            color: kWhiteColor,
                          ),
                          onPressed: () {
                            Get.toNamed(Routes.settingScreen);
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SizedBox(
                          width: 150,
                          child: Column(
                            children: [
                              Container(
                                padding: const EdgeInsets.only(top: 10),
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: kWhiteColor,
                                  border: Border.all(
                                    color: kAmberColor,
                                    width: 2,
                                  ),
                                ),
                                clipBehavior: Clip.antiAlias,
                                child: const Iconify(
                                  Fontisto.male,
                                  size: 40,
                                  color: kAmberColor,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                controller.userName,
                                style: kBodyText.copyWith(height: 1),
                              ),
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'اشتراک:',
                                    style: kBodyText.copyWith(height: 1),
                                  ),
                                  const SizedBox(width: 5),
                                  Text(
                                    controller.user?.subscribeMonth == null
                                        ? 'پایه'
                                        : '${controller.user?.subscribeMonth} ماهه',
                                    style: kBodyText.copyWith(height: 1),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 150,
                          child: Column(
                            children: [
                              Text(
                                controller.subscribe.toStringAsFixed(0),
                                style: kBodyLarge,
                              ),
                              const SizedBox(height: 10),
                              const Text(
                                'روز باقی مانده از اشتراک',
                                style: kBodyText,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        InkWell(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                          onTap: () {
                            Get.toNamed(Routes.activityScreen);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10)),
                              border: Border.all(
                                color: kLightGreyColor,
                                width: 1.5,
                              ),
                              color: kLightGreenAccentColor.withOpacity(0.6),
                            ),
                            padding: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 35),
                            alignment: Alignment.center,
                            child: const Text(
                              'فعالیت ها',
                              style: kBodyText,
                            ),
                          ),
                        ),
                        InkWell(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                          onTap: () {
                            Get.toNamed(Routes.subscribeScreen);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10)),
                              border: Border.all(
                                width: 1.5,
                                color: kWhiteColor,
                              ),
                              color: kWhiteColor,
                            ),
                            padding: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 35),
                            alignment: Alignment.center,
                            child: Text(
                              'تهیه اشتراک',
                              style: kBodyText.copyWith(
                                color: kBlackColor,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            body: Column(
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: kGreyColor.withAlpha(25),
                        width: 20,
                      ),
                      shape: BoxShape.circle,
                    ),
                    height: 120,
                    width: 120,
                    alignment: Alignment.center,
                    child: FittedBox(
                      child: Text(
                        controller.showTotalTime
                            ? controller.timeReadingTotal.toString()
                            : controller.timeReadingDay.toString(),
                        style: kBodyLarge,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircleButtonWidget(
                            color: controller.showTotalTime
                                ? kLightGreenAccentColor.withOpacity(0.1)
                                : kLightGreenAccentColor,
                            onTap: () {
                              controller.showTotalTime = false;
                              controller.update();
                            },
                            height: 40,
                            width: 120,
                            child: Text(
                              'امروز',
                              style: kBodyMedium.copyWith(color:controller.showTotalTime? kBlackColor:kWhiteColor),
                            ),
                          ),
                          const SizedBox(width: 20),
                          CircleButtonWidget(
                            color: !controller.showTotalTime
                                ? kLightGreenAccentColor.withOpacity(0.1)
                                : kLightGreenAccentColor,
                            onTap: () {
                              controller.showTotalTime = true;
                              controller.update();
                            },
                            height: 40,
                            width: 120,
                            child: Text(
                              'کل',
                              style: kBodyMedium.copyWith(color:controller.showTotalTime? kWhiteColor:kBlackColor),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        'میزان مطالعه شما${controller.showTotalTime ? controller.timeUnitTotal.toString() : controller.timeUnitDay.toString()}',
                        style: kBodyMedium.copyWith(
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
