import 'dart:developer';

import 'package:audio_session/audio_session.dart';
import 'package:get/get.dart';
import 'package:gosheno/app/controllers/home_controller.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';

class AudioPlayerController extends GetxController {
  final player = Get.find<HomeController>().player;

  Rx<MediaItem> currentSong = MediaItem(
    id: '2',
    title: '102',
    artist: 'دارن هاردی',
    displayDescription:
        'اثر مرکب همیشه کار می کند و همیشه شما را جایی خواهد برد.',
    artUri: Uri.parse(
        'https://upmusics.com/wp-content/uploads/2022/04/IMG_20220406_210952_989.jpg'),
  ).obs;
  RxList<MediaItem> playList = <MediaItem>[].obs;

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
    _init();
    _listenForChangesInSequenceState();
    _listenToPlaybackState();
    _listenToCurrentPosition();
    _listenToTotalDuration();
    player.play();
  }

  Future<void> _init() async {
    final session = await AudioSession.instance;
    await session.configure(const AudioSessionConfiguration.speech());

    player.playbackEventStream.listen((event) {},
        onError: (Object e, StackTrace stackTrace) {
      log('A stream error occurred: $e');
    });
    try {
      final playList = ConcatenatingAudioSource(children: [
        AudioSource.uri(
          Uri.parse(
              'https://dl.my-ahangha.ir/up/2019/Erfan%20-%20Khate%20Man%20128.mp3'),
          tag: MediaItem(
            id: '1',
            title: "اثر مرکب",
            artist: 'دارن هاردی',
            displayDescription:
                'اثر مرکب همیشه کار می کند و همیشه شما را جایی خواهد برد.',
            artUri: Uri.parse(
                'https://liwa.ir/wp-content/uploads/hqdefault-3-e1514574191762.jpg'),
          ),
        ),
        AudioSource.uri(
          Uri.parse(
              'https://irsv.upmusics.com/99/Aron%20Afshar%20%7C%20Khandehato%20Ghorboon%20(128).mp3'),
          tag: MediaItem(
            id: '2',
            title: "اثر",
            artist: 'دارن هاردی',
            displayDescription:
                'اثر مرکب همیشه کار می کند و همیشه شما را جایی خواهد برد.',
            artUri: Uri.parse(
                'https://upmusics.com/wp-content/uploads/2022/04/IMG_20220406_210952_989.jpg'),
          ),
        ),
        AudioSource.uri(
          Uri.parse(
              'http://www.s4.topseda.ir/nevisande/reza/1396/music/05/10/Moein%20-%20Jane%20Man%20%28128%29.mp3'),
          tag: MediaItem(
            id: '3',
            title: "مرکب",
            artist: 'دارن هاردی',
            displayDescription:
                'اثر مرکب همیشه کار می کند و همیشه شما را جایی خواهد برد.',
            artUri: Uri.parse(
                'https://musicirani.org/wp-content/uploads/2018/07/745-Moein-JaneMan.jpg'),
          ),
        ),
      ]);
      if (currentSong.value.title == '102') {
        await player.setAudioSource(playList);
      }
    } catch (e) {
      log("Error loading audio source: $e");
    }
  }

  void _listenForChangesInSequenceState() {
    player.sequenceStateStream.listen((sequenceState) {
      if (sequenceState == null) return;

      final currentItem = sequenceState.currentSource;
      currentSong.value = currentItem?.tag as MediaItem;

      final playlist = sequenceState.effectiveSequence;
      playList.value = playlist.map((item) => item.tag as MediaItem).toList();
    });
  }

  void _listenToPlaybackState() {
    player.playerStateStream.listen((playerState) async {
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
        await player.stop();
        player.seek(Duration.zero);
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

  void seekToPrevious() {
    if (player.hasPrevious) {
      player.seekToPrevious();
    } //
    else {
      player.seek(Duration.zero);
    }
  }

  void seekToNext() {
    if (player.hasNext) {
      player.seekToNext();
    }
  }

  void stop() async {
    await player.stop();
    progressNotifier.value = ProgressBarState(
      current: Duration.zero,
      total: Duration.zero,
    );
  }
}

enum ButtonState { paused, playing, loading }

class ProgressBarState {
  final Duration current;
  final Duration total;

  ProgressBarState({required this.current, required this.total});
}
