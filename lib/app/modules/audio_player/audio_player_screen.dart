import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:gosheno/app/modules/audio_player/audio_player_controller.dart';
import 'package:gosheno/app/modules/audio_player/local_widget/seek_bar.dart';

import '../../core/theme/app_color.dart';
import '../../core/theme/app_text_theme.dart';

class AudioPlayerScreen extends GetView<AudioPlayerController> {
  const AudioPlayerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: kGreenAccentColor,
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  color: Colors.black,
                  child: Opacity(
                    opacity: 0.45,
                    child: Obx(
                      () => CachedNetworkImage(
                        imageUrl:
                            controller.currentSong.value.artUri.toString(),
                        height: Get.height * 0.7 - 30,
                        width: Get.width,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  left: 0,
                  child: AppBar(
                    elevation: 0,
                    backgroundColor: Colors.transparent,
                    leading: IconButton(
                      onPressed: () {
                        Get.back();
                      },
                      icon: const Icon(Icons.arrow_back_ios),
                      splashRadius: 25,
                    ),
                  ),
                ),
                Obx(() {
                  final item = controller.currentSong.value;
                  return Container(
                    height: Get.height * 0.7,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.title,
                          style: kBodyMedium.copyWith(color: kWhiteColor),
                        ),
                        const SizedBox(height: 5),
                        Text(item.artist!, style: kWhiteText),
                        const SizedBox(height: 20),
                        Text(item.displayDescription!, style: kWhiteText),
                      ],
                    ),
                  );
                }),
                const SeekBar(),
              ],
            ),
            Expanded(
              child: Directionality(
                textDirection: TextDirection.ltr,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                          onPressed: () {
                            controller.seekTo10Second(false);
                          },
                          icon: const Icon(Icons.replay_10_rounded),
                          // iconSize: 28,
                          color: kWhiteColor,
                        ),
                        IconButton(
                          onPressed: () {
                            controller.seekToPrevious();
                          },
                          icon: const Icon(FeatherIcons.skipBack),
                          iconSize: 36,
                          color: kWhiteColor,
                        ),
                        Obx(() {
                          if (controller.buttonNotifier.value ==
                              ButtonState.loading) {
                            return Container(
                              margin: const EdgeInsets.all(8),
                              padding: const EdgeInsets.all(10),
                              width: 64,
                              height: 64,
                              child: const CircularProgressIndicator(
                                color: kWhiteColor,
                              ),
                            );
                          } else if (controller.buttonNotifier.value ==
                              ButtonState.paused) {
                            return IconButton(
                              icon: const Icon(FeatherIcons.playCircle),
                              iconSize: 64,
                              color: kWhiteColor,
                              onPressed: controller.player.play,
                            );
                          } else {
                            return IconButton(
                              icon: const Icon(FeatherIcons.pauseCircle),
                              iconSize: 64,
                              color: kWhiteColor,
                              onPressed: controller.player.pause,
                            );
                          }
                        }),
                        IconButton(
                          onPressed: () {
                            controller.seekToNext();
                          },
                          icon: const Icon(FeatherIcons.skipForward),
                          iconSize: 36,
                          color: kWhiteColor,
                        ),
                        IconButton(
                          onPressed: () {
                            controller.seekTo10Second(true);
                          },
                          icon: const Icon(Icons.forward_10_rounded),
                          // iconSize: 28,
                          color: kWhiteColor,
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    GetBuilder<AudioPlayerController>(
                      builder: (_) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: controller.speedList.map((index) {
                            return GestureDetector(
                              onTap: () {
                                controller.speedIndex =
                                    controller.speedList.indexOf(index);
                                controller.player.setSpeed(index);
                                _.update();
                              },
                              child: Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Text(
                                  '$index x',
                                  style: controller.speedList.indexOf(index) ==
                                          controller.speedIndex
                                      ? kBodyText.copyWith(
                                          color: kAmberColor,
                                          fontWeight: FontWeight.w900,
                                        )
                                      : kBodyText.copyWith(
                                          color: kWhiteColor,
                                          fontWeight: FontWeight.w900,
                                        ),
                                ),
                              ),
                            );
                          }).toList(),
                        );
                        //   SizedBox(-
                        //   width: Get.width,
                        //   height: 60,
                        //   child: ListView.separated(
                        //     itemCount: controller.speedList.length,
                        //     scrollDirection: Axis.horizontal,
                        //     itemBuilder: (context, index) {
                        //       return GestureDetector(
                        //         onTap: () {
                        //           controller.speedIndex = index;
                        //           controller.player.value
                        //               .setSpeed(controller.speedList[index]);
                        //           _.update();
                        //         },
                        //         child: Text(
                        //           '${controller.speedList[index]} x',
                        //           style: index == controller.speedIndex
                        //               ? kWhiteText.copyWith(
                        //                   color: kLightGreenAccentColor)
                        //               : kWhiteText,
                        //         ),
                        //       );
                        //     },
                        //     separatorBuilder: (context, index) {
                        //       return const SizedBox(width: 20);
                        //     },
                        //   ),
                        // );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
