import 'package:gosheno/app/data/provider/api_provider.dart';

class UserRepository {
  final MyApiClient apiClient;

  UserRepository({required this.apiClient});

  Future registerUser({
    required String name,
    required String phoneNumber,
    required String pass,
    required String email,
  }) async {
    return await apiClient.registerUser(name, phoneNumber, pass, email);
  }

  Future loginUser({
    required String phoneNumber,
    required String pass,
    required String email,
  }) async {
    return await apiClient.loginUser(phoneNumber, pass, email);
  }

  Future<bool> sendSms({required String toPhoneNumber,required String smsCode})async{
    return await apiClient.sendSms(smsCode, toPhoneNumber);
  }
}
