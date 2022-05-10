import 'dart:developer';

import 'package:audio_session/audio_session.dart';
import 'package:get/get.dart';
import 'package:gosheno/app/controllers/home_controller.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';

class AudioPlayerController extends GetxController {
  final player = Get.find<HomeController>().player;
  String url = Get.arguments ??
      "https://irsv.upmusics.com/99/Aron%20Afshar%20%7C%20Khandehato%20Ghorboon%20(128).mp3";
  late final LockCachingAudioSource audioSource;

  Rx<ButtonState> buttonNotifier = ButtonState.paused.obs;
  Rx<ProgressBarState> progressNotifier = ProgressBarState(
    current: Duration.zero,
    total: Duration.zero,
  ).obs;

  int speedIndex = 0;
  List<double> speedList = [1, 1.25, 1.5, 2];

  double? dragValue;

  @override
  void onInit() {
    super.onInit();
    if (audioSource.uri.toString() != url) {
      audioSource = LockCachingAudioSource(
        Uri.parse(url),
        tag: MediaItem(
          id: '1',
          title: "اثر مرکب",
          artist: 'دارن هاردی',
          displayDescription:
              'اثر مرکب همیشه کار می کند و همیشه شما را جایی خواهد برد.',
          artUri: Uri.parse(
              'https://upmusics.com/wp-content/uploads/2022/04/IMG_20220406_210952_989.jpg'),
        ),
      );
    }
    _init();
    _listenToPlaybackState();
    _listenToCurrentPosition();
    _listenToBufferedPosition();
    _listenToTotalDuration();
    if (!player.value.playing) {
      player.value.play();
    }
  }

  Future<void> _init() async {
    final session = await AudioSession.instance;
    await session.configure(const AudioSessionConfiguration.speech());

    player.value.playbackEventStream.listen((event) {},
        onError: (Object e, StackTrace stackTrace) {
      log('A stream error occurred: $e');
    });
    try {
      await player.value.setAudioSource(audioSource);
    } catch (e) {
      log("Error loading audio source: $e");
    }
  }

  void _listenToPlaybackState() {
    player.value.playerStateStream.listen((playerState) async {
      final isPlaying = playerState.playing;
      final processingState = playerState.processingState;
      if (processingState == ProcessingState.loading ||
          processingState == ProcessingState.buffering) {
        buttonNotifier.value = ButtonState.loading;
      } else if (!isPlaying) {
        buttonNotifier.value = ButtonState.paused;
      } else if (processingState != ProcessingState.completed) {
        buttonNotifier.value = ButtonState.playing;
      } else {
        buttonNotifier.value = ButtonState.paused;
        await player.value.stop();
        player.value.seek(Duration.zero);
      }
    });
  }

  void _listenToCurrentPosition() {
    player.value.positionStream.listen((position) {
      final oldState = progressNotifier.value;
      progressNotifier.value = ProgressBarState(
        current: position,
        total: oldState.total,
      );
    });
  }

  void _listenToBufferedPosition() {
    audioSource.downloadProgressStream.listen((bufferedPosition) {
      final oldState = progressNotifier.value;
      progressNotifier.value = ProgressBarState(
        current: oldState.current,
        total: oldState.total,
      );
    });
  }

  void _listenToTotalDuration() {
    player.value.durationStream.listen((totalDuration) {
      final oldState = progressNotifier.value;
      progressNotifier.value = ProgressBarState(
        current: oldState.current,
        total: totalDuration ?? Duration.zero,
      );
    });
  }

  void seekTo10Second(bool isNext) {
    if (!isNext) {
      if (progressNotifier.value.current < const Duration(seconds: 10)) {
        return;
      }
      player.value
          .seek(progressNotifier.value.current - const Duration(seconds: 10));
    } //
    else {
      player.value
          .seek(progressNotifier.value.current + const Duration(seconds: 10));
    }
  }
}

enum ButtonState { paused, playing, loading }

class ProgressBarState {
  final Duration current;
  final Duration total;

  ProgressBarState({required this.current, required this.total});
}
