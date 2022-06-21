import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gosheno/app/modules/profile/profile_controller.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ProfileController controller = Get.put(ProfileController());
    return Scaffold(
      appBar: AppBar(
        title: const Text('پروفایل'),
        centerTitle: true,
      ),
      body: Padding(
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
    );
  }
}
