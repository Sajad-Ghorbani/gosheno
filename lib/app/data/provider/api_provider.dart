import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:http/http.dart' as http;

const baseUrl = 'http://sunict.ir/wbs/webservice.php';
const smsUrl = 'https://rest.payamak-panel.com/api/SendSMS/BaseServiceNumber';

class MyApiClient {
  final http.Client httpClient;

  MyApiClient({required this.httpClient});

  Future registerUser(
      String name, String phoneNumber, String pass, String email) async {
    try {
      // Create a Map for body to post request
      Map<String, String> body = {
        'RequestType': 'reguser',
        'name': name,
        'mobile': phoneNumber,
        'password': pass,
        'email': email,
      };
      var response = await httpClient.post(
        Uri.parse(baseUrl),
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
          HttpHeaders.authorizationHeader: 'bd6d553fc3af11c7ba3793d87ef28e53',
        },
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
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
          HttpHeaders.authorizationHeader: 'bd6d553fc3af11c7ba3793d87ef28e53',
        },
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
        if (result['value'].length > 10) {
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
}
