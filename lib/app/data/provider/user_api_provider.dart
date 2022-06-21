import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:gosheno/app/core/utils/app_constants.dart';
import 'package:gosheno/app/data/models/book_model.dart';
import 'package:gosheno/app/data/models/user_model.dart';
import 'package:http/http.dart' as http;

class UserApiClient {
  final http.Client httpClient;

  UserApiClient({required this.httpClient});

  String baseUrl = webserviceBaseUrl;
  String smsUrl = smsApiUrl;
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
      Map<String, dynamic> body = {
        'username': '09124124539',
        'password': '2B#ZR',
        'text': code,
        'to': to,
        'bodyId': '70765',
      };
      var response = await http.post(
        Uri.parse(smsUrl),
        headers: {
          'content-type': 'application/x-www-form-urlencoded',
        },
        body: body,
      );
      if (response.statusCode == 200) {
        var result = json.decode(response.body);
        if (result['Value'].length > 10) {
          return true;
        } //
        else {
          return false;
        }
      } //
      return false;
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
        if (result.runtimeType == Map) {
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

  Future getMyBooks(int id) async {
    try {
      var response = await httpClient.post(
        Uri.parse(baseUrl),
        headers: headers,
        body: {
          'RequestType': 'mybooks',
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
}
