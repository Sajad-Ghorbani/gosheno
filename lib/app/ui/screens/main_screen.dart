import 'package:animations/animations.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:gosheno/app/controllers/home_controller.dart';
import 'package:gosheno/app/ui/theme/app_color.dart';

class MainScreen extends GetView<HomeController> {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GetBuilder<HomeController>(builder: (_) {
          return PageTransitionSwitcher(
            duration: const Duration(seconds: 1),
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
                  const Icon(
                    FeatherIcons.home,
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
                  const Icon(
                    FeatherIcons.fileText,
                    color: kWhiteColor,
                  ),
                  controller.currentIndex != 1
                      ? const Text(
                          'یادداشت',
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
                  const Icon(
                    FeatherIcons.book,
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
                  const Icon(
                    FeatherIcons.user,
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
    );
  }
}
