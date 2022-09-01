import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:gosheno/app/core/utils/app_constants.dart';
import 'package:gosheno/app/data/models/activity_model.dart';
import 'package:gosheno/app/data/models/coupon_model.dart';
import 'package:gosheno/app/data/models/user_model.dart';

class UserApiClient {
  Dio dio = Dio(AppConstants.dioOptions);

  Future registerUser(
      String name, String? phoneNumber, String pass, String? email) async {
    try {
      Dio mDio = Dio();
      // Create a Map for body to post request
      Map<String, String> body = {
        'name': name,
        'password': pass,
        'mobile': phoneNumber ?? '',
        'email': email ?? '',
        'sex': '',
      };

      FormData data = FormData.fromMap(body);

      var response = await mDio.post(
        'https://gosheno.com/api/v1/register',
        options: Options(
          contentType: 'application/json',
          headers: {
            'Authorization': 'bd6d553fc3af11c7ba3793d87ef28e53',
            'Accept': 'application/json',
          },
          method: 'POST',
        ),
        data: data,
      );
      if (response.statusCode == 200) {
        var result = response.data;
        User user = User.fromJson(result);
        return {
          'status': true,
          'user': user,
        };
      } //
      else {
        log('error -get');
      }
    } //
    on DioError catch (e) {
      if (e.response!.statusCode == 500) {
        return {
          'status': false,
          'error':
              'خطایی در ارتباط با سرور رخ داده است. لطفا دوباره تلاش کنید.',
        };
      } else if (e.response!.statusCode == 422) {
        var result = e.response!.data;
        return {
          'status': false,
          'error': result['errors']['password'] ??
              result['errors']['mobile'] ??
              result['errors']['email'],
        };
      } //
      else {
        log('error -post');
        log(e.toString());
        return {
          'status': false,
          'error':
              'خطایی در ارتباط با سرور رخ داده است. لطفا دوباره تلاش کنید.',
        };
      }
    }
  }

  Future loginUser(String phoneNumber, String pass) async {
    try {
      // Create a Map for body to post request
      FormData body = FormData.fromMap({
        'mobile': phoneNumber,
        'password': pass,
      });
      var response = await dio.request(
        '/login',
        options: Options(
          method: 'POST',
        ),
        data: body,
      );
      if (response.statusCode == 200) {
        var result = response.data;
        User user = User.fromJson(result);
        return {
          'status': true,
          'user': user,
        };
      } //
      else {
        log('error -get');
      }
    } //
    on DioError catch (e) {
      if (e.response!.statusCode == 500) {
        return {
          'status': false,
          'error':
              'خطایی در ارتباط با سرور رخ داده است. لطفا دوباره تلاش کنید.',
        };
      } //
      else if (e.response!.statusCode == 401) {
        var result = e.response!.data;
        return {
          'status': false,
          'error': result['message'],
        };
      } //
      log('error -get');
      log(e.toString());
    }
  }

  Future<bool> sendSms(String code, String to) async {
    try {
      Dio mDio = Dio();
      var response = await mDio.get(
          'http://ippanel.com:8080/?apikey=8dxRku-H4fM1KfuBEnqFw_hPrCKttJLxsvLo1pzzKVw=&pid=7tenu6cbn3akg66&fnum=+983000505&tnum=$to&p1=code&v1=$code');
      if (response.statusCode == 201) {
        return true;
      } //
      else {
        return false;
      }
    } //
    catch (e) {
      log(e.toString());
      return false;
    }
  }

  Future getUser(int id) async {
    try {
      var response = await dio.request(
        '/user/$id',
        options: Options(
          method: 'GET',
        ),
      );
      if (response.statusCode == 200) {
        var result = response.data;
        User user = User.fromJson(result);
        return {
          'status': true,
          'user': user,
        };
      } //
      else {
        return {
          'status': false,
        };
      }
    } //
    catch (e) {
      log('error -get');
      log(e.toString());
    }
  }

  Future checkSubscribe(int id) async {
    try {
      var response = await dio.request(
        '/user/subscribe/$id',
        options: Options(
          method: 'GET',
        ),
      );
      if (response.statusCode == 200) {
        Map result = response.data;
        int subscribe = result['days'];
        return {
          'status': true,
          'subscribe': subscribe,
        };
      } //
      else {
        return {
          'status': false,
        };
      }
    } //
    catch (e) {
      log('error -get');
      log(e.toString());
    }
  }

  Future editUser(
    int id,
    String name,
    String phoneNumber,
    String email,
    String password,
    int sex,
  ) async {
    try {
      FormData body = FormData.fromMap({
        'name': name,
        'mobile': phoneNumber,
        'password': password,
        'email': email,
        'sex': sex.toString(),
      });
      var response = await dio.request(
        '/user/edit/$id',
        options: Options(method: 'POST'),
        data: body,
      );
      if (response.statusCode == 200) {
        var result = response.data;
        return {
          'status': true,
          'message': result['message'],
        };
      } //
      else if (response.statusCode == 422) {
        var result = response.data;
        return {
          'status': false,
          'error': result['errors']['password'] ??
              result['errors']['mobile'] ??
              result['errors']['email'] ??
              result['errors']['sex'],
        };
      } //
      else {
        log('error -get');
      }
    } //
    catch (e) {
      log('error -post');
      log(e.toString());
    }
  }

  Future resetPassword(String phoneNumber) async {
    try {
      FormData body = FormData.fromMap({
        'mobile': phoneNumber,
      });
      var response = await dio.request(
        '/resetpassword',
        options: Options(
          method: 'POST',
        ),
        data: body,
      );
      if (response.statusCode == 200) {
        var result = response.data;
        return {
          'status': true,
          'code': result['code'],
        };
      } else {
        var result = response.data;
        return {
          'status': false,
          'error': result['errors']['mobile'],
        };
      }
    } //
    catch (e) {
      log('error -post');
      log(e.toString());
    }
  }

  Future confirmPassword(String phoneNumber) async {
    try {
      FormData body = FormData.fromMap({
        'mobile': phoneNumber,
      });
      var response = await dio.request(
        '/confirmpassword',
        options: Options(
          method: 'POST',
        ),
        data: body,
      );
      if (response.statusCode == 200) {
        return {
          'status': true,
        };
      } else {
        return {
          'status': false,
        };
      }
    } //
    catch (e) {
      log('error -post');
      log(e.toString());
    }
  }

  Future getCoupons() async {
    try {
      var response = await dio.request(
        '/coupons',
        options: Options(
          method: 'GET',
        ),
      );
      if (response.statusCode == 200) {
        var result = response.data;
        List<Coupon> coupons = [];
        for (var item in result) {
          coupons.add(Coupon.fromJson(item));
        }
        return {
          'status': true,
          'coupons': coupons,
        };
      } //
      else {
        return {
          'status': false,
        };
      }
    } //
    catch (e) {
      log('error -get');
      log(e.toString());
    }
  }

  Future getUserActivities(int id) async {
    try {
      var response = await dio.request(
        '/comments/user/$id',
        options: Options(
          method: 'GET',
        ),
      );
      if (response.statusCode == 200) {
        List result = response.data;
        List<Activity> activities = [];
        for (var item in result) {
          activities.add(Activity.fromJson(item));
        }
        return {
          'status': true,
          'activities': activities,
        };
      } //
      else {
        return {
          'status': false,
        };
      }
    } //
    catch (e) {
      log('error -get');
      log(e.toString());
    }
  }

  Future existUserEmail(String email) async {
    try {
      var response = await dio.request(
        '/user/check',
        options: Options(
          method: 'POST',
        ),
        data: FormData.fromMap({
          'email': email,
        }),
      );
      if (response.statusCode == 200) {
        return {
          'status': true,
          'id':response.data['id'],
        };
      } //
      else {
        return {
          'status': false,
        };
      }
    } //
    catch (e) {
      log('error -get');
      log(e.toString());
    }
  }
}
