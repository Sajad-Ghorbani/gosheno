import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gosheno/app/core/theme/app_color.dart';
import 'package:gosheno/app/global_widgets/loading.dart';
import 'package:gosheno/app/modules/profile/profile_controller.dart';
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
                title: SizedBox(
                  height: 300,
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
                            onPressed: () {},
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Column(
                            children: [
                              const CircleAvatar(
                                radius: 28,
                                backgroundColor: kAmberColor,
                                child: CircleAvatar(
                                  backgroundColor: kWhiteColor,
                                  radius: 22,
                                  child: Padding(
                                    padding: EdgeInsets.only(top: 10),
                                    child: Iconify(
                                      Fontisto.male,
                                      size: 40,
                                      color: kAmberColor,
                                    ),
                                  ),
                                ),
                              ),
                              Text(controller.userName),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                centerTitle: true,
                toolbarHeight: 300,
              ),
              body: SingleChildScrollView(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    const Divider(height: 1),
                    ListTile(
                      title: const Text('کیف پول'),
                      onTap: () {},
                    ),
                    const Divider(height: 1),
                    ListTile(
                      title: const Text('کد تخفیف و امتیازات'),
                      onTap: () {},
                    ),
                    const Divider(height: 1),
                    ListTile(
                      title: const Text('مدیریت دستگاه'),
                      onTap: () {},
                    ),
                    const Divider(height: 1),
                    ListTile(
                      title: const Text('تکمیل اطلاعات'),
                      onTap: () {},
                    ),
                    const Divider(height: 1),
                    ListTile(
                      title: const Text('سوالات متداول'),
                      onTap: () {},
                    ),
                    const Divider(height: 1),
                    ListTile(
                      title: const Text('درباره ما'),
                      onTap: () {},
                    ),
                    const Divider(height: 1),
                    ListTile(
                      title: const Text('وبلاگ'),
                      onTap: () {},
                    ),
                    const Divider(height: 1),
                    ListTile(
                      title: const Text('خروج'),
                      onTap: () {
                        controller.logout();
                      },
                    ),
                    const Divider(height: 1),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
