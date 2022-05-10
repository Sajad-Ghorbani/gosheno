import 'package:get/get.dart';
import 'package:gosheno/app/controllers/audio_player_controller.dart';

class AudioPlayerBinding implements Bindings{
  @override
  void dependencies() {
    Get.put<AudioPlayerController>(AudioPlayerController());
  }
}