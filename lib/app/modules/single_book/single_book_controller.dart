import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gosheno/app/data/repository/repository.dart';

class SingleBookController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final MyRepository myRepository;

  SingleBookController(this.myRepository);
  double opacityAnimation = 0;
  ScrollController scrollController = ScrollController();
  double containerMargin = 30;
  double containerRadius = 24;
  String heroTag = Get.arguments;

  @override
  void onInit() {
    super.onInit();
    scrollController.addListener(() {
      if (scrollController.offset > 200) {
        opacityAnimation = 1;
        containerMargin = 0;
        containerRadius = 0;
        update();
      } //
      else {
        opacityAnimation = 0;
        containerMargin = 30;
        containerRadius = 24;
        update();
      }
    });
  }


}
