import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gosheno/app/core/theme/app_color.dart';
import 'package:lottie/lottie.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({Key? key, required this.child, required this.isLoading})
      : super(key: key);
  final Widget child;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        if (isLoading)
          Container(
            width: Get.width,
            height: Get.height,
            color: kDarkGreyColor.withOpacity(0.6),
            child: Lottie.asset(
              'assets/animations/loading_gosheno.json',
            ),
          ),
      ],
    );
  }
}
