import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gosheno/app/core/theme/app_color.dart';
import 'package:gosheno/app/core/theme/app_text_theme.dart';
import 'package:gosheno/app/global_widgets/circle_button_widget.dart';
import 'package:gosheno/app/global_widgets/custom_text_field.dart';
import 'package:gosheno/app/modules/profile/profile_controller.dart';
import 'package:gosheno/app/modules/profile/setting/edit_profile.dart';
import 'package:gosheno/app/routes/app_pages.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/fa_regular.dart';
import 'package:persian_number_utility/persian_number_utility.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
      builder: (controller) {
        return Scaffold(
          backgroundColor: const Color(0xFFD3E0E0),
          appBar: AppBar(
            title: const Text('تنظیمات'),
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
          body: ListView(
            padding: const EdgeInsets.symmetric(vertical: 20),
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Row(
                  children: [
                    const Text(
                      'اطلاعات کاربری',
                      style: kBodyMedium,
                    ),
                    const SizedBox(width: 5),
                    OpenContainer(
                      closedShape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                      transitionDuration: const Duration(milliseconds: 500),
                      closedBuilder: (context, action) => const Padding(
                        padding: EdgeInsets.fromLTRB(10, 10, 8, 10),
                        child: Iconify(
                          FaRegular.edit,
                          color: kGreenAccentColor,
                          size: 18,
                        ),
                      ),
                      openBuilder: (context, action) => const EditProfile(),
                    ),
                  ],
                ),
              ),
              ListTile(
                title: const Text('نام'),
                trailing: Text('${controller.user?.name}', style: kBodyMedium),
                tileColor: kWhiteGreyColor,
              ),
              const Divider(height: 0.2),
              ListTile(
                title: const Text('موبایل'),
                trailing: Text(controller.user?.mobile ?? 'ثبت نشده'),
                tileColor: kWhiteGreyColor,
              ),
              const Divider(height: 0.2),
              ListTile(
                title: const Text('ایمیل'),
                trailing: Text(controller.user?.email ?? 'ثبت نشده'),
                tileColor: kWhiteGreyColor,
              ),
              const SizedBox(height: 10),
              ListTile(
                title: const Text('اشتراک'),
                trailing: Text(
                    controller.user?.subscribeMonth == null
                        ? 'پایه'
                        : '${controller.user?.subscribeMonth} ماهه',
                    style: kBodyMedium),
                tileColor: kWhiteGreyColor,
              ),
              const Divider(height: 0.2),
              ListTile(
                trailing: InkWell(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  onTap: () {
                    Get.toNamed(Routes.subscribeScreen);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      border: Border.all(
                        color: kLightGreenAccentColor,
                        width: 1.5,
                      ),
                    ),
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                    child: Text(
                      'تهیه اشتراک',
                      style: kBodyText.copyWith(
                        color: kGreenAccentColor,
                      ),
                    ),
                  ),
                ),
                tileColor: kWhiteGreyColor,
              ),
              const Divider(height: 0.2),
              ListTile(
                title: const Text('کیف پول'),
                trailing: Text(
                  '${controller.user?.wallet!.seRagham() ?? '0'} تومان',
                  style: kBodyMedium.copyWith(
                    color: kGreenAccentColor,
                  ),
                ),
                tileColor: kWhiteGreyColor,
              ),
              const Divider(height: 0.2),
              ListTile(
                trailing: InkWell(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  onTap: () {
                    Get.defaultDialog(
                      title: 'شارژ کیف پول',
                      content: Column(
                        children: [
                          CustomTextField(
                            labelText: 'مبلغ را وارد کنید',
                            controller: controller.walletAmountController,
                            keyboardType: TextInputType.number,
                          ),
                          const SizedBox(height: 10),
                          const Padding(
                            padding: EdgeInsets.all(10),
                            child: FittedBox(
                              child: Text(
                                'حداقل مبلغ: 10.000 تومان و حداکثر: 50.000.000',
                              ),
                            ),
                          ),
                        ],
                      ),
                      actions: [
                        CircleButtonWidget(
                          onTap: () {
                            Get.back();
                            controller.walletAmountController.clear();
                          },
                          width: 80,
                          height: 35,
                          color: kRedColor,
                          child: const Text(
                            'بازگشت',
                            style: TextStyle(color: kWhiteColor),
                          ),
                        ),
                        CircleButtonWidget(
                          onTap: () {
                            controller.chargeWallet();
                          },
                          width: 80,
                          height: 35,
                          color: kGreenAccentColor,
                          child: const Text(
                            'تایید',
                            style: TextStyle(color: kWhiteColor),
                          ),
                        ),
                      ],
                      onWillPop: () {
                        controller.walletAmountController.clear();
                        return Future.value(true);
                      },
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      border: Border.all(
                        color: kLightGreenAccentColor,
                        width: 1.5,
                      ),
                    ),
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                    child: Text(
                      'شارژ کیف پول',
                      style: kBodyText.copyWith(
                        color: kGreenAccentColor,
                      ),
                    ),
                  ),
                ),
                tileColor: kWhiteGreyColor,
              ),
              const SizedBox(height: 10),
              ListTile(
                title: const Text('کد تخفیف'),
                trailing: const Icon(
                  Icons.arrow_forward_ios,
                  color: kGreenAccentColor,
                ),
                onTap: () {
                  Get.toNamed(Routes.couponScreen);
                },
                tileColor: kWhiteGreyColor,
              ),
              const Divider(height: 0.2),
              ListTile(
                title: const Text(
                  'خروج از حساب کاربری',
                  style: TextStyle(color: kRedColor),
                ),
                onTap: () {
                  controller.logout();
                },
                tileColor: kWhiteGreyColor,
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: (){
                  controller.openGitigetSite();
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'طراحی شده توسط تیم گیتی گت',
                    ),
                    const SizedBox(width: 10),
                    Image.asset(
                      'assets/images/GitigetLogo.png',
                      width: 30,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
