import 'package:flutter/material.dart';
import 'package:gosheno/app/core/theme/app_color.dart';
import 'package:gosheno/app/core/utils/constants_styles.dart';

import 'app_text_theme.dart';

class AppThemeData {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: kWhiteGreyColor,
      canvasColor: kWhiteGreyColor,
      colorScheme: const ColorScheme(
        brightness: Brightness.light,
        primary: kGreenAccentColor,
        onPrimary: kWhiteColor,
        secondary: kDarkRedColor,
        onSecondary: Colors.white,
        error: kRedColor,
        onError: kWhiteColor,
        background: kWhiteColor,
        onBackground: kBlackColor,
        surface: kWhiteGreyColor,
        onSurface: kGreyColor,
      ),
      fontFamily: 'Yekan',
      appBarTheme: AppBarTheme(
        elevation: 1,
        shape: appBarShape,
        titleTextStyle: kBodyMedium.copyWith(
          fontFamily: 'Yekan',
          height: 1,
        ),
      ),
      textTheme: const TextTheme(
        bodyText2: kBodyText,
        bodyText1: kBodyLarge,
        headline6: kBodyMedium,
      ),
    );
  }
}
