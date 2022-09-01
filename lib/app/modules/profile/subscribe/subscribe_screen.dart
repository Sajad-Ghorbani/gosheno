import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gosheno/app/core/theme/app_color.dart';
import 'package:gosheno/app/modules/profile/local_widget/subscribe_card.dart';
import 'package:gosheno/app/modules/profile/profile_controller.dart';

class SubscribeScreen extends StatelessWidget {
  const SubscribeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('تهیه اشتراک'),
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
            padding: const EdgeInsets.all(20),
            children: [
              SubscribeCard(
                color: const Color(0xffda8a67),
                subscribeMonth: '1',
                type: 'برنزی',
                booksViewCount: '12',
                price: '100,000',
                offPrice: '54,000',
                onTap: () {
                  controller.buySubscribe(1);
                },
              ),
              const SizedBox(height: 20),
              SubscribeCard(
                color: kGreyColor,
                subscribeMonth: '6',
                type: 'نقره ای',
                booksViewCount: '96',
                price: '600,000',
                offPrice: '292,000',
                onTap: () {
                  controller.buySubscribe(6);
                },
              ),
              const SizedBox(height: 20),
              SubscribeCard(
                color: kAmberColor,
                subscribeMonth: '12',
                type: 'طلایی',
                booksViewCount: 'نامحدود',
                price: '1,200,000',
                offPrice: '569,000',
                onTap: () {
                  controller.buySubscribe(12);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
