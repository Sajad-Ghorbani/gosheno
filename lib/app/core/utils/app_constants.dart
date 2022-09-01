import 'dart:io';

import 'package:dio/dio.dart';

class AppConstants {
  static const String baseUrl = 'https://gosheno.com';

  static const String userIdKey = 'userId';
  static const String loggedInKey = 'loggedIn';

  static const String readingTimeTotalKey = 'readingTime';
  static const String readingTimeDayKey = 'readingTimeDay';
  static const String cartKey = 'cart';

  static var dioOptions = BaseOptions(
    headers: {
      HttpHeaders.authorizationHeader:
          'bd6d553fc3af11c7ba3793d87ef28e53',
    },
    baseUrl: 'https://gosheno.com/api/v1',
    contentType: 'application/json',
  );
}
