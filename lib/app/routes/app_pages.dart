import 'package:get/get.dart';
import 'package:gosheno/app/modules/audio_player/audio_player_binding.dart';
import 'package:gosheno/app/modules/comment/comment_binding.dart';
import 'package:gosheno/app/modules/home/all_book/all_book.dart';
import 'package:gosheno/app/modules/home/category/category_screen.dart';
import 'package:gosheno/app/modules/book/single_book/single_book_screen.dart';
import 'package:gosheno/app/modules/home/home_binding.dart';
import 'package:gosheno/app/modules/book/book_binding.dart';
import 'package:gosheno/app/modules/user/login/login_screen.dart';
import 'package:gosheno/app/modules/user/user_binding.dart';
import 'package:gosheno/app/modules/audio_player/audio_player_screen.dart';
import 'package:gosheno/app/modules/comment/comments_screen.dart';
import 'package:gosheno/app/modules/user/signup/signup_screen.dart';
import 'package:gosheno/app/modules/home/main_screen.dart';
import 'package:gosheno/app/modules/user/verify_phone/verify_phone_screen.dart';

part './app_routes.dart';

class AppRoutes {
  static List<GetPage> pages = [
    GetPage(
      name: Routes.loginScreen,
      page: () => const LoginScreen(),
      binding: UserBinding(),
    ),
    GetPage(name: Routes.signupScreen, page: () => const SignupScreen()),
    GetPage(
        name: Routes.verifyPhoneScreen, page: () => const VerifyPhoneScreen()),
    GetPage(
      name: Routes.mainScreen,
      page: () => const MainScreen(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: Routes.singleBookScreen,
      page: () => const SingleBookScreen(),
      binding: BookBinding(),
    ),
    GetPage(
      name: Routes.commentsScreen,
      page: () => const CommentsScreen(),
      binding: CommentBinding(),
    ),
    GetPage(
      name: Routes.audioPlayerScreen,
      page: () => const AudioPlayerScreen(),
      binding: AudioPlayerBinding(),
    ),
    GetPage(name: Routes.categoryScreen, page: () => const CategoryScreen()),
    GetPage(name: Routes.allBookScreen, page: () => const AllBookScreen()),
  ];
}
