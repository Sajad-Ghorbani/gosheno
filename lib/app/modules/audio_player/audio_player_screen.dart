import 'package:animations/animations.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:gosheno/app/modules/audio_player/audio_player_controller.dart';
import 'package:gosheno/app/modules/audio_player/local_widget/seek_bar.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/ep.dart';
import 'package:iconify_flutter/icons/fluent.dart';
import 'package:iconify_flutter/icons/ri.dart';

import '../../core/theme/app_color.dart';
import '../../core/theme/app_text_theme.dart';

class AudioPlayerScreen extends GetView<AudioPlayerController> {
  const AudioPlayerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Container(
          color: Colors.black,
          child: Opacity(
            opacity: 0.45,
            child: CachedNetworkImage(
              imageUrl: controller.selectedSong.artUri.toString(),
              height: Get.height,
              width: Get.width,
              fit: BoxFit.cover,
            ),
          ),
        ),
        GetBuilder<AudioPlayerController>(
          builder: (_) {
            return Scaffold(
              backgroundColor:
                  controller.showBookContent ? Colors.transparent : null,
              appBar: AppBar(
                elevation: 0,
                backgroundColor: Colors.transparent,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero,
                ),
                leading: IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: const Icon(Icons.arrow_back_ios),
                  splashRadius: 25,
                  color: controller.showBookContent
                      ? kWhiteGreyColor
                      : kBlackColor,
                ),
                actions: [
                  // Container(
                  //   padding: const EdgeInsets.symmetric(vertical: 10),
                  //   child: CircleButtonWidget(
                  //     color: kDarkRedColor,
                  //     onTap: () {
                  //       controller.downloadBookPdf();
                  //     },
                  //     height: 35,
                  //     child: const Text(
                  //       'دانلود نسخه الکترونیکی',
                  //       style: TextStyle(color: kWhiteGreyColor, fontSize: 12),
                  //     ),
                  //   ),
                  // ),
                  IconButton(
                    onPressed: () {
                      controller.toggleShowContent();
                    },
                    icon: controller.showBookContent
                        ? const Iconify(
                            Ri.book_3_line,
                            color: kWhiteGreyColor,
                          )
                        : const Iconify(
                            Fluent.headphones_32_regular,
                            color: kBlackColor,
                          ),
                    splashRadius: 25,
                  ),
                  const SizedBox(width: 5),
                ],
              ),
              body: PageTransitionSwitcher(
                duration: const Duration(milliseconds: 500),
                transitionBuilder:
                    (child, primaryAnimation, secondaryAnimation) {
                  return FadeThroughTransition(
                    animation: primaryAnimation,
                    secondaryAnimation: secondaryAnimation,
                    fillColor: Colors.transparent,
                    child: child,
                  );
                },
                child: controller.showBookContent
                    ? Column(
                        children: [
                          Stack(
                            children: [
                              Container(
                                height: Get.height * 0.7 - 80,
                                width: Get.width,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      controller.selectedSong.title,
                                      style: kBodyMedium.copyWith(
                                          color: kWhiteColor),
                                    ),
                                    const SizedBox(height: 5),
                                    Text(controller.selectedSong.artist!,
                                        style: kWhiteText),
                                    const SizedBox(height: 20),
                                    Text(
                                        controller
                                            .selectedSong.displayDescription!,
                                        style: kWhiteText),
                                  ],
                                ),
                              ),
                              const SeekBar(),
                            ],
                          ),
                          Expanded(
                            child: Directionality(
                              textDirection: TextDirection.ltr,
                              child: Container(
                                color: kBlueGreyColor,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        IconButton(
                                          onPressed: () {
                                            controller.seekTo10Second(false);
                                          },
                                          icon: const Icon(
                                              Icons.replay_10_rounded),
                                          // iconSize: 28,
                                          color: kWhiteColor,
                                        ),
                                        // IconButton(
                                        //   onPressed: () {
                                        //     controller.seekToPrevious();
                                        //   },
                                        //   icon: const Iconify(Lucide.skip_back,size: 36,color: kWhiteColor,),
                                        //   iconSize: 36,
                                        //
                                        // ),
                                        Obx(
                                          () {
                                            if (controller
                                                    .buttonNotifier.value ==
                                                ButtonState.loading) {
                                              return Container(
                                                margin: const EdgeInsets.all(8),
                                                padding:
                                                    const EdgeInsets.all(10),
                                                width: 64,
                                                height: 64,
                                                child:
                                                    const CircularProgressIndicator(
                                                  color: kWhiteColor,
                                                ),
                                              );
                                            } else if (controller
                                                    .buttonNotifier.value ==
                                                ButtonState.paused) {
                                              return IconButton(
                                                icon: const Iconify(
                                                  Ep.video_play,
                                                  size: 64,
                                                  color: kWhiteColor,
                                                ),
                                                iconSize: 64,
                                                color: kWhiteColor,
                                                onPressed:
                                                    controller.player.play,
                                              );
                                            } else {
                                              return IconButton(
                                                icon: const Iconify(
                                                  Ep.video_pause,
                                                  size: 64,
                                                  color: kWhiteColor,
                                                ),
                                                iconSize: 64,
                                                color: kWhiteColor,
                                                onPressed:
                                                    controller.player.pause,
                                              );
                                            }
                                          },
                                        ),
                                        // IconButton(
                                        //   onPressed: () {
                                        //     controller.seekToNext();
                                        //   },
                                        //   icon: const Iconify(Lucide.skip_forward,size: 36,color: kWhiteColor,),
                                        //   iconSize: 36,
                                        //   color: kWhiteColor,
                                        // ),
                                        IconButton(
                                          onPressed: () {
                                            controller.seekTo10Second(true);
                                          },
                                          icon: const Icon(
                                              Icons.forward_10_rounded),
                                          // iconSize: 28,
                                          color: kWhiteColor,
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 20),
                                    GetBuilder<AudioPlayerController>(
                                      builder: (_) {
                                        return Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children:
                                              controller.speedList.map((index) {
                                            return GestureDetector(
                                              onTap: () {
                                                controller.setSpeed(index);
                                              },
                                              child: Container(
                                                margin:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 10),
                                                child: Text(
                                                  '$index x',
                                                  style: controller.speedList
                                                              .indexOf(index) ==
                                                          controller.speedIndex
                                                      ? kBodyText.copyWith(
                                                          color: kAmberColor,
                                                          fontWeight:
                                                              FontWeight.w900,
                                                        )
                                                      : kBodyText.copyWith(
                                                          color: kWhiteColor,
                                                          fontWeight:
                                                              FontWeight.w900,
                                                        ),
                                                ),
                                              ),
                                            );
                                          }).toList(),
                                        );
                                      },
                                    ),
                                    const SizedBox(height: 20),
                                    Image.asset(
                                      'assets/images/gosheno-logo-typo.png',
                                      height: Get.height * 0.05,
                                    ),
                                    const SizedBox(height: 10),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    : SingleChildScrollView(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 20,
                        ),
                        child: HtmlWidget(
                          controller.selectedSong.extras!['bookContent'],
                        ),
                      ),
              ),
            );
          },
        ),
      ],
    );
  }
}
