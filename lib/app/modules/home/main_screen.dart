import 'package:animations/animations.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gosheno/app/modules/home/home_controller.dart';
import 'package:gosheno/app/core/theme/app_color.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/bx.dart';
import 'package:iconify_flutter/icons/fluent.dart';
import 'package:iconify_flutter/icons/ri.dart';
import 'package:iconify_flutter/icons/uil.dart';

class MainScreen extends GetView<HomeController> {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if(controller.currentIndex == 0){
          return true;
        }//
        else{
          controller.currentIndex = 0;
          controller.update();
          return false;
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: GetBuilder<HomeController>(builder: (_) {
            return PageTransitionSwitcher(
              duration: const Duration(milliseconds: 400),
              transitionBuilder:
                  (child, primaryAnimation, secondaryAnimation) {
                return SharedAxisTransition(
                  animation: primaryAnimation,
                  secondaryAnimation: secondaryAnimation,
                  transitionType: SharedAxisTransitionType.scaled,
                  child: child,
                );
              },
              child: controller.listWidgets[controller.currentIndex],
            );
          }),
        ),
        bottomNavigationBar: GetBuilder<HomeController>(
          builder: (_) {
            return CurvedNavigationBar(
              items: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    controller.currentIndex != 0
                        ? const SizedBox(height: 5)
                        : const SizedBox.shrink(),
                    const Iconify(
                      Uil.home_alt,
                      color: kWhiteColor,
                    ),
                    controller.currentIndex != 0
                        ? const Text(
                            'خانه',
                            style: TextStyle(color: kWhiteColor),
                          )
                        : const SizedBox.shrink(),
                  ],
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    controller.currentIndex != 1
                        ? const SizedBox(height: 5)
                        : const SizedBox.shrink(),
                    const Iconify(
                      Bx.category,
                      color: kWhiteColor,
                    ),
                    controller.currentIndex != 1
                        ? const Text(
                            'دسته بندی',
                            style: TextStyle(color: kWhiteColor),
                          )
                        : const SizedBox.shrink()
                  ],
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    controller.currentIndex != 2
                        ? const SizedBox(height: 5)
                        : const SizedBox.shrink(),
                    const Iconify(
                      Ri.book_3_line,
                      color: kWhiteColor,
                    ),
                    controller.currentIndex != 2
                        ? const Text(
                            'کتابخانه',
                            style: TextStyle(color: kWhiteColor),
                          )
                        : const SizedBox.shrink()
                  ],
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    controller.currentIndex != 3
                        ? const SizedBox(height: 5)
                        : const SizedBox.shrink(),
                    const Iconify(
                      Fluent.person_32_regular,
                      color: kWhiteColor,
                    ),
                    controller.currentIndex != 3
                        ? const Text(
                            'پروفایل',
                            style: TextStyle(color: kWhiteColor),
                          )
                        : const SizedBox.shrink()
                  ],
                ),
              ],
              backgroundColor: Colors.transparent,
              color: Theme.of(context).colorScheme.primary,
              height: 60,
              index: controller.currentIndex,
              animationDuration: const Duration(milliseconds: 400),
              onTap: (int value) {
                controller.currentIndex = value;
                controller.update();
              },
            );
          },
        ),
      ),
    );
  }
}
