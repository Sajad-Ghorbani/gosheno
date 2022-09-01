import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gosheno/app/core/theme/app_color.dart';
import 'package:gosheno/app/core/theme/app_text_theme.dart';
import 'package:gosheno/app/data/models/coupon_model.dart';
import 'package:gosheno/app/modules/profile/profile_controller.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/ep.dart';
import 'package:persian_number_utility/persian_number_utility.dart';

class CouponScreen extends GetView<ProfileController> {
  const CouponScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('آخرین تخفیفات'),
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
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 10),
            child: Text(
              'از آخرین تخفیفات گوشنو خبردار شوید.',
              style: kBodyMedium,
            ),
          ),
          const Divider(
            color: kGreenAccentColor,
            endIndent: 50,
            indent: 50,
          ),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(vertical: 10),
              itemCount: controller.couponList.length,
              itemBuilder: (context, index) {
                Coupon coupon = controller.couponList[index];
                String time = DateTime.fromMillisecondsSinceEpoch(
                        int.parse(coupon.expireAt) * 1000)
                    .toPersianDate();
                return ListTile(
                  title: Row(
                    children: [
                      Text(
                        'کد تخفیف: ${coupon.name}',
                        style: kBodyMedium,
                      ),
                      const SizedBox(width: 5),
                      GestureDetector(
                        onTap: () {
                          controller.copyCoupon(coupon.name);
                        },
                        child: const Iconify(
                          Ep.copy_document,
                          color: kAmberColor,
                          size: 18,
                        ),
                      ),
                    ],
                  ),
                  subtitle: Text(coupon.content),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('تاریخ انقضا'),
                      const SizedBox(height: 5),
                      Text(
                        time,
                        style: const TextStyle(color: kRedColor),
                      ),
                    ],
                  ),
                  leading: Text(
                    '${coupon.val}%',
                    style: kBodyMedium.copyWith(
                      color: kGreenAccentColor,
                    ),
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return const Divider();
              },
            ),
          ),
        ],
      ),
    );
  }
}
