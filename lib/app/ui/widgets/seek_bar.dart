import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gosheno/app/controllers/audio_player_controller.dart';
import 'package:gosheno/app/ui/theme/app_color.dart';

class SeekBar extends StatelessWidget {
  const SeekBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      right: 0,
      left: 0,
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: GetX<AudioPlayerController>(
          builder: (controller) {
            final position = controller.progressNotifier.value;
            String totalTime = RegExp(r'((^0*[1-9]\d*:)?\d{2}:\d{2})\.\d+$')
                .firstMatch("${position.total}")
                ?.group(1) ??
                '${position.total}';
            String currentTime = RegExp(r'((^0*[1-9]\d*:)?\d{2}:\d{2})\.\d+$')
                .firstMatch("${position.current}")
                ?.group(1) ??
                '${position.current}';
            return SizedBox(
              height: 60,
              child: Stack(
                children: [
                  SliderTheme(
                    data: SliderThemeData(
                      activeTrackColor: Colors.blue.shade100,
                      inactiveTrackColor: Colors.grey.shade300,
                      trackHeight: 5,
                      thumbColor: Colors.white,
                      thumbShape: const RoundSliderThumbShape(
                        enabledThumbRadius: 8,
                        pressedElevation: 8,
                      ),
                      overlayShape: const RoundSliderOverlayShape(
                        overlayRadius: 0,
                      ),
                    ),
                    child: Slider(
                      min: 0.0,
                      max: position.total.inMilliseconds.toDouble(),
                      value: min(
                          controller.dragValue ??
                              position.current.inMilliseconds.toDouble(),
                          position.total.inMilliseconds.toDouble()),
                      onChanged: (value) {
                        controller.dragValue = value;
                        controller.update();
                      },
                      onChangeEnd: (value) {
                        controller.player
                            .seek(Duration(milliseconds: value.round()));
                        controller.dragValue = null;
                        controller.update();
                      },
                    ),
                  ),
                  Positioned(
                    top: 0,
                    right: 10,
                    child: Text(
                      totalTime,
                      style: const TextStyle(color: kWhiteColor),
                    ),
                  ),
                  Positioned(
                    left: 10,
                    top: 0,
                    child: Text(
                      currentTime,
                      style: const TextStyle(color: kWhiteColor),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
