import 'package:get/get.dart';
import 'package:gosheno/app/modules/audio_player/audio_player_controller.dart';

class AudioPlayerBinding implements Bindings{
  @override
  void dependencies() {
    Get.put<AudioPlayerController>(AudioPlayerController());
  }
}