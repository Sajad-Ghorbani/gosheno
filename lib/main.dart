import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:gosheno/app/routes/app_pages.dart';
import 'package:gosheno/app/ui/theme/app_theme.dart';
import 'package:just_audio_background/just_audio_background.dart';

void main()async {
  await JustAudioBackground.init(
    androidNotificationChannelId: 'com.example.gosheno',
    androidNotificationChannelName: 'Audio playback',
    androidNotificationOngoing: true,
    androidShowNotificationBadge: true,
  );
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
      getPages: AppRoutes.pages,
      defaultTransition: Transition.rightToLeftWithFade,
      transitionDuration: const Duration(milliseconds: 300),
      theme: AppThemeData.lightTheme,
    );
  }
}
