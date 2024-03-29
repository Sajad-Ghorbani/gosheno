import 'dart:async';
import 'dart:developer';

import 'package:audio_session/audio_session.dart';
import 'package:get/get.dart';
import 'package:gosheno/app/core/utils/app_constants.dart';
import 'package:gosheno/app/core/utils/extensions.dart';
import 'package:gosheno/app/data/models/book_model.dart';
import 'package:gosheno/app/modules/home/home_controller.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AudioPlayerController extends GetxController {
  final player = Get.find<HomeController>().player;

  final Book _book = Get.arguments;

  late MediaItem selectedSong;
  MediaItem? currentAudio;

  Rx<ButtonState> buttonNotifier = ButtonState.paused.obs;
  Rx<ProgressBarState> progressNotifier = ProgressBarState(
    current: Duration.zero,
    total: Duration.zero,
  ).obs;

  int speedIndex = 0;
  List<double> speedList = [1, 1.25, 1.5, 2];

  double? dragValue;
  bool showBookContent = true;

  Duration startTimeTotal = const Duration(seconds: 1);
  Duration startTimeDay = const Duration(seconds: 1);

  @override
  void onInit() {
    super.onInit();
    selectedSong = MediaItem(
      id: _book.id.toString(),
      title: _book.name,
      artist: _book.author,
      displayDescription: _book.short,
      artUri: Uri.parse('${AppConstants.baseUrl}${_book.pic}'),
      extras: {
        'bookContent': _book.content,
      },
    );
    _init();
    _listenForChangesInSequenceState();
    _listenToPlaybackState();
    _listenToCurrentPosition();
    _listenToTotalDuration();
    player.play();
  }

  setReadingTime() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String timeTotal = pref.getString(AppConstants.readingTimeTotalKey) ?? '0';
    String timeDay = pref.getString(AppConstants.readingTimeDayKey) ?? '0';
    if (timeDay == '0' && timeTotal == '0') {
      Timer(const Duration(seconds: 1), () {
        pref.setString(
            AppConstants.readingTimeDayKey, '$startTimeDay/${DateTime.now()}');
        pref.setString(
            AppConstants.readingTimeTotalKey, startTimeTotal.toString());
      });
    } //
    else {
      if (timeDay == '0') {
        Timer(const Duration(seconds: 1), () {
          pref.setString(AppConstants.readingTimeDayKey,
              '$startTimeDay/${DateTime.now()}');

          startTimeTotal = timeTotal.parseDuration();
          Duration newTime = startTimeTotal + const Duration(seconds: 1);
          pref.setString(AppConstants.readingTimeTotalKey, newTime.toString());
        });
      } //
      else {
        DateTime day = (timeDay.split('/').last).toDate();
        DateTime now = DateTime.now();
        if (day.day == now.day &&
            day.month == now.month &&
            day.year == now.year) {
          Timer(const Duration(seconds: 1), () {
            startTimeDay = (timeDay.split('/').first).parseDuration();
            Duration newTimeDay = startTimeDay + const Duration(seconds: 1);
            pref.setString(AppConstants.readingTimeDayKey,
                '$newTimeDay/${DateTime.now()}');

            startTimeTotal = timeTotal.parseDuration();
            Duration newTime = startTimeTotal + const Duration(seconds: 1);
            pref.setString(
                AppConstants.readingTimeTotalKey, newTime.toString());
          });
        } //
        else {
          Timer(const Duration(seconds: 1), () {
            pref.setString(AppConstants.readingTimeDayKey,
                '$startTimeDay/${DateTime.now()}');

            startTimeTotal = timeTotal.parseDuration();
            Duration newTime = startTimeTotal + const Duration(seconds: 1);
            pref.setString(
                AppConstants.readingTimeTotalKey, newTime.toString());
          });
        }
      }
    }
  }

  Future<void> _init() async {
    final session = await AudioSession.instance;
    await session.configure(const AudioSessionConfiguration.speech());

    player.playbackEventStream.listen((event) {},
        onError: (Object e, StackTrace stackTrace) {
      log('A stream error occurred: $e');
    });
    try {
      if (currentAudio != null && currentAudio!.id == selectedSong.id) {
        //pass
      } //
      else {
        await player.setAudioSource(
          LockCachingAudioSource(
            Uri.parse(
                '${AppConstants.baseUrl}${_book.soundDemo ?? _book.soundLink}'),
            tag: selectedSong,
          ),
        );
      }
    } catch (e) {
      log("Error loading audio source: $e");
    }
  }

  void _listenForChangesInSequenceState() {
    player.sequenceStateStream.listen((sequenceState) {
      if (sequenceState == null) return;

      final currentItem = sequenceState.currentSource;
      currentAudio = currentItem?.tag as MediaItem;
    });
  }

  void _listenToPlaybackState() {
    player.playerStateStream.listen((playerState) {
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
        player.seek(Duration.zero);
        stop();
      }
    });
  }

  void _listenToCurrentPosition() {
    player.positionStream.listen((position) {
      final oldState = progressNotifier.value;
      progressNotifier.value = ProgressBarState(
        current: position,
        total: oldState.total,
      );
      // print(position.toString().split('.').last);
      if (double.parse(position.toString().split('.').last.substring(0, 1)) <
          2) {
        // print(position);
        setReadingTime();
      }
    });
  }

  void _listenToTotalDuration() {
    player.durationStream.listen((totalDuration) {
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
      player.seek(progressNotifier.value.current - const Duration(seconds: 10));
    } //
    else {
      player.seek(progressNotifier.value.current + const Duration(seconds: 10));
    }
  }

  void stop() async {
    await player.stop();
    progressNotifier.value = ProgressBarState(
      current: Duration.zero,
      total: Duration.zero,
    );
  }

  void setSpeed(double index) {
    speedIndex = speedList.indexOf(index);
    player.setSpeed(index);
    update();
  }

  void toggleShowContent() {
    if (_book.content != null) {
      showBookContent = !showBookContent;
      update();
    }
  }
}

enum ButtonState { paused, playing, loading }

class ProgressBarState {
  final Duration current;
  final Duration total;

  ProgressBarState({required this.current, required this.total});
}
