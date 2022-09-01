import 'package:get/get.dart';
import 'package:gosheno/app/modules/activity/activity_binding.dart';
import 'package:gosheno/app/modules/activity/activity_screen.dart';
import 'package:gosheno/app/modules/audio_player/audio_player_binding.dart';
import 'package:gosheno/app/modules/cart/cart_binding.dart';
import 'package:gosheno/app/modules/cart/cart_screen.dart';
import 'package:gosheno/app/modules/category/category_binding.dart';
import 'package:gosheno/app/modules/comment/comment_binding.dart';
import 'package:gosheno/app/modules/home/all_book/all_book.dart';
import 'package:gosheno/app/modules/book/single_book/single_book_screen.dart';
import 'package:gosheno/app/modules/category/books_of_category/books_of_category_screen.dart';
import 'package:gosheno/app/modules/home/home_binding.dart';
import 'package:gosheno/app/modules/book/book_binding.dart';
import 'package:gosheno/app/modules/payment/payment_binding.dart';
import 'package:gosheno/app/modules/payment/payment_screen.dart';
import 'package:gosheno/app/modules/profile/coupon/coupon_screen.dart';
import 'package:gosheno/app/modules/profile/setting/setting_screen.dart';
import 'package:gosheno/app/modules/profile/subscribe/subscribe_screen.dart';
import 'package:gosheno/app/modules/user/login/login_screen.dart';
import 'package:gosheno/app/modules/user/splash/splash_screen.dart';
import 'package:gosheno/app/modules/audio_player/audio_player_screen.dart';
import 'package:gosheno/app/modules/comment/comments_screen.dart';
import 'package:gosheno/app/modules/user/signup/signup_screen.dart';
import 'package:gosheno/app/modules/home/main_screen.dart';
import 'package:gosheno/app/modules/user/verify_phone/verify_phone_screen.dart';

part './app_routes.dart';

class AppRoutes {
  static List<GetPage> pages = [
    GetPage(
      name: '/',
      page: () => const SplashScreen(),
    ),
    GetPage(
      name: Routes.loginScreen,
      page: () => const LoginScreen(),
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
    GetPage(
      name: Routes.categoryScreen,
      page: () => const BooksOfCategoryScreen(),
      binding: CategoryBinding(),
    ),
    GetPage(name: Routes.allBookScreen, page: () => const AllBookScreen()),
    GetPage(name: Routes.settingScreen, page: () => const SettingScreen()),
    GetPage(name: Routes.couponScreen, page: () => const CouponScreen()),
    GetPage(name: Routes.subscribeScreen, page: () => const SubscribeScreen()),
    GetPage(
      name: Routes.paymentScreen,
      page: () => const PaymentScreen(),
      binding: PaymentBinding(),
    ),
    GetPage(
      name: Routes.cartScreen,
      page: () => const CartScreen(),
      binding: CartBinding(),
    ),
    GetPage(
      name: Routes.activityScreen,
      page: () => const ActivityScreen(),
      binding: ActivityBinding(),
    ),
  ];
}
