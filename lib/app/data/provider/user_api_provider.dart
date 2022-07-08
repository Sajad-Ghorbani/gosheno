import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:gosheno/app/core/utils/app_constants.dart';
import 'package:gosheno/app/data/models/book_model.dart';
import 'package:gosheno/app/data/models/copun_model.dart';
import 'package:gosheno/app/data/models/user_model.dart';
import 'package:http/http.dart' as http;

class UserApiClient {
  final http.Client httpClient;

  UserApiClient({required this.httpClient});

  String baseUrl = AppConstants.webserviceBaseUrl;
  Map<String, String> headers = {
    'Content-Type': 'application/x-www-form-urlencoded',
    HttpHeaders.authorizationHeader: 'bd6d553fc3af11c7ba3793d87ef28e53',
  };

  Future registerUser(
      String name, String? phoneNumber, String pass, String? email) async {
    try {
      // Create a Map for body to post request
      Map<String, String> body = {
        'RequestType': 'reguser',
        'name': name,
        'password': pass,
      };
      if (phoneNumber != null) {
        body['mobile'] = phoneNumber;
      }
      if (email != null) {
        body['email'] = email;
      }
      var response = await httpClient.post(
        Uri.parse(baseUrl),
        headers: headers,
        body: body,
      );
      if (response.statusCode == 200) {
        List result = json.decode(response.body);
        if (result.length == 1) {
          int id = int.parse(result.first);
          return {
            'status': true,
            'id': id,
          };
        } //
        else {
          return {
            'status': false,
            'error': result[1],
          };
        }
      } else {
        log('error -get');
      }
    } //
    catch (_) {}
  }

  Future loginUser(String phoneNumber, String pass, String email) async {
    try {
      // Create a Map for body to post request
      Map<String, String> body = {
        'RequestType': 'loginuser',
        'mobile': phoneNumber,
        'password': pass,
        'email': email,
      };

      var response = await httpClient.post(
        Uri.parse(baseUrl),
        headers: headers,
        body: body,
      );
      if (response.statusCode == 200) {
        var result = json.decode(response.body);
        if (result is Map) {
          int id = int.parse(result['id']);
          return {
            'status': true,
            'id': id,
          };
        } //
        else {
          return {
            'status': false,
            'error': result[1],
          };
        }
      } else {
        log('error -get');
      }
    } //
    catch (_) {}
  }

  Future<bool> sendSms(String code, String to) async {
    try {
      var response = await http.get(
        Uri.parse(
            'http://ippanel.com:8080/?apikey=8dxRku-H4fM1KfuBEnqFw_hPrCKttJLxsvLo1pzzKVw=&pid=7tenu6cbn3akg66&fnum=+983000505&tnum=$to&p1=code&v1=$code'),
      );
      if (response.statusCode == 201) {
        return true;
      } //
      else {
        return false;
      }
    } //
    catch (_) {
      return false;
    }
  }

  Future getUser(int id) async {
    try {
      var response = await httpClient.post(
        Uri.parse(baseUrl),
        headers: headers,
        body: {
          'RequestType': 'userinfo',
          'uid': id.toString(),
        },
      );
      if (response.statusCode == 200) {
        var result = json.decode(response.body);
        if (result[0] != 'error') {
          User user = User.fromJson(result);
          return {
            'status': true,
            'user': user,
          };
        } //
        else {
          return {
            'status': false,
            'error': result[1],
          };
        }
      } else {
        log('error -get');
      }
    } //
    catch (_) {}
  }

  Future checkSubscribe(int id) async {
    try {
      var response = await httpClient.post(
        Uri.parse(baseUrl),
        headers: headers,
        body: {
          'RequestType': 'checksubscrib',
          'uid': id.toString(),
        },
      );
      if (response.statusCode == 200) {
        var result = json.decode(response.body);
        if (result.runtimeType == double) {
          return {
            'status': true,
            'subscribe': result,
          };
        } //
        else {
          return {
            'status': false,
            'error': result[1],
          };
        }
      } else {
        log('error -get');
      }
    } //
    catch (_) {}
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
      Map<String, String> body = {
        'RequestType': 'edituser',
        'uid': id.toString(),
        'name': name,
        'mobile': phoneNumber,
        'password': password,
        'email': email,
        'sex': sex.toString(),
      };
      var response = await httpClient.post(
        Uri.parse(baseUrl),
        headers: headers,
        body: body,
      );
      if (response.statusCode == 200) {
        var result = json.decode(response.body);
        if (result.runtimeType == String) {
          return {
            'status': true,
          };
        } //
        else {
          return {
            'status': false,
            'error': result[1],
          };
        }
      } else {
        log('error -get');
      }
    } //
    catch (_) {}
  }

  Future getBuyBooks(int id) async {
    try {
      var response = await httpClient.post(
        Uri.parse(baseUrl),
        headers: headers,
        body: {
          'RequestType': 'buybooks',
          'uid': id.toString(),
        },
      );
      if (response.statusCode == 200) {
        var result = json.decode(response.body);
        if (result[0] != 'error') {
          List<Book> books = result.map((book) => Book.fromJson(book)).toList();
          return {
            'status': true,
            'books': books,
          };
        } //
        else {
          return {
            'status': false,
            'error': result[1],
          };
        }
      } //
      else {
        log('error -get');
      }
    } //
    catch (_) {}
  }

  Future resetPassword(String phoneNumber) async {
    try {
      Map<String, String> body = {
        'RequestType': 'resetpassword',
        'mobile': phoneNumber,
      };
      var response = await httpClient.post(
        Uri.parse(baseUrl),
        headers: headers,
        body: body,
      );
      if (response.statusCode == 200) {
        var result = json.decode(response.body);
        if (result[0] != 'error') {
          return {
            'status': true,
            'token': result[1],
          };
        } //
        else {
          return {
            'status': false,
            'error': result[1],
          };
        }
      } else {
        log('error -get');
      }
    } //
    catch (_) {}
  }

  Future confirmPassword(String phoneNumber) async {
    try {
      Map<String, String> body = {
        'RequestType': 'confirmpassword',
        'mobile': phoneNumber,
      };
      var response = await httpClient.post(
        Uri.parse(baseUrl),
        headers: headers,
        body: body,
      );
      if (response.statusCode == 200) {
        var result = json.decode(response.body);
        if (result[0] != 'error') {
          return {
            'status': true,
          };
        } //
        else {
          return {
            'status': false,
            'error': result[1],
          };
        }
      } else {
        log('error -get');
      }
    } //
    catch (_) {}
  }

  Future getCopuns() async {
    try {
      var response = await httpClient.post(
        Uri.parse(baseUrl),
        headers: headers,
        body: {
          'RequestType': 'copuns',
        },
      );
      if (response.statusCode == 200) {
        var result = json.decode(response.body);
        if (result[0] != 'error') {
          List<Copun> copuns =
              result.map((copun) => Copun.fromJson(copun)).toList();
          return {
            'status': true,
            'copuns': copuns,
          };
        } //
        else {
          return {
            'status': false,
            'error': result[1],
          };
        }
      } //
      else {
        log('error -get');
      }
    } //
    catch (_) {}
  }
}
