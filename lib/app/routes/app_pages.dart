import 'package:get/get.dart';
import 'package:gosheno/app/bindings/audio_player_binding.dart';
import 'package:gosheno/app/bindings/home_binding.dart';
import 'package:gosheno/app/bindings/single_book_binding.dart';
import 'package:gosheno/app/ui/screens/audio_player_screen.dart';
import 'package:gosheno/app/ui/screens/comments_screen.dart';
import 'package:gosheno/app/ui/screens/login_screen.dart';
import 'package:gosheno/app/ui/screens/signup_screen.dart';
import 'package:gosheno/app/ui/screens/main_screen.dart';
import 'package:gosheno/app/ui/screens/single_book_screen.dart';

part './app_routes.dart';

class AppRoutes {
  static List<GetPage> pages = [
    GetPage(name: Routes.loginScreen, page: () => const LoginScreen()),
    GetPage(name: Routes.signupScreen, page: () => const SignupScreen()),
    GetPage(
      name: Routes.mainScreen,
      page: () => const MainScreen(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: Routes.singleBookScreen,
      page: () => const SingleBookScreen(),
      binding: SingleBookBinding(),
    ),
    GetPage(name: Routes.commentsScreen, page: () => const CommentsScreen()),
    GetPage(
      name: Routes.audioPlayerScreen,
      page: () => const AudioPlayerScreen(),
      binding: AudioPlayerBinding(),
    ),
  ];
}
