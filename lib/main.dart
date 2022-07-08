import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:gosheno/app/core/theme/app_color.dart';
import 'package:gosheno/app/routes/app_pages.dart';
import 'package:gosheno/app/core/theme/app_theme.dart';
import 'package:just_audio_background/just_audio_background.dart';

import 'app/modules/user/user_binding.dart';

void main() async {
  await JustAudioBackground.init(
    androidNotificationChannelId: 'com.gosheno.audiobook',
    androidNotificationChannelName: 'Audio playback',
    androidNotificationOngoing: true,
    androidShowNotificationBadge: true,
  );
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: kGreenAccentColor.withOpacity(0.6),
  ));
  runApp(
    DevicePreview(
      enabled: false,
      builder: (context) => const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Gosheno',
      useInheritedMediaQuery: true,
      builder: DevicePreview.appBuilder,
      locale: const Locale('fa', 'IR'),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('fa', ''),
        Locale('en', ''),
      ],
      fallbackLocale: const Locale('en', 'US'),
      initialRoute: Routes.loginScreen,
      initialBinding: UserBinding(),
      getPages: AppRoutes.pages,
      defaultTransition: Transition.rightToLeftWithFade,
      transitionDuration: const Duration(milliseconds: 300),
      theme: AppThemeData.lightTheme,
    );
  }
}
