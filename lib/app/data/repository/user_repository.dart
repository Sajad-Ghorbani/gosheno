import 'package:gosheno/app/data/provider/user_api_provider.dart';

class UserRepository {
  final UserApiClient apiClient;

  UserRepository({required this.apiClient});

  /// This method is used to register new user.
  ///
  /// [name] is the name of user.
  /// [phoneNumber] is the phone number of user.
  /// [pass] is the password of user.
  /// [email] is the email of user.
  ///
  /// Returns a [Future] that contains a [Map] with the following keys:
  /// - `status`: `true` if the user is registered successfully, otherwise `false`.
  /// - `id`: `int` if the user is registered successfully, otherwise `null`.
  /// - `error`: `String` if the user is not registered successfully, otherwise `null`.
  Future registerUser({
    required String name,
    String? phoneNumber,
    required String pass,
    String? email,
  }) async {
    return await apiClient.registerUser(name, phoneNumber, pass, email);
  }

  /// This method is used to login user.
  ///
  /// [phoneNumber] is the phone number of user.
  /// [pass] is the password of user.
  /// [email] is the email of user.
  ///
  /// Returns a [Future] that contains a [Map] with the following keys:
  /// - `status`: `true` if the user is logged in successfully, otherwise `false`.
  /// - `id`: `int` if the user is logged in successfully, otherwise `null`.
  /// - `error`: `String` if the user is not logged in successfully, otherwise `null`.
  Future loginUser({
    required String phoneNumber,
    required String pass,
    required String email,
  }) async {
    return await apiClient.loginUser(phoneNumber, pass, email);
  }

  /// This method is used to send sms.
  ///
  /// [toPhoneNumber] is the phone number to send sms.
  /// [smsCode] is the code that send to user.
  ///
  /// Returns a [Future] that contains a [bool]:
  /// - `true` if the sms is sent successfully, otherwise `false`.
  Future<bool> sendSms(
      {required String toPhoneNumber, required String smsCode}) async {
    return await apiClient.sendSms(smsCode, toPhoneNumber);
  }

  /// This method is used to get user information.
  ///
  /// [id] is the id of user.
  ///
  /// Returns a [Future] that contains a [Map] with the following keys:
  /// - `status`: `true` if get user information successfully, otherwise `false`.
  /// - `user`: `User` if get user information successfully, otherwise `null`.
  /// - `error`: `String` if get user information unsuccessfully, otherwise `null`.
  Future getUserInfo({required int id}) async {
    return await apiClient.getUser(id);
  }

  /// This method is used to check user subscribe.
  ///
  /// [id] is the id of user.
  ///
  /// Returns a [Future] that contains a [Map] with the following keys:
  /// - `status`: `true` if check user subscribe successfully, otherwise `false`.
  /// - `subscribe`: `double` if check user subscribe successfully, otherwise `null`.
  /// - `error`: `String` if check user subscribe unsuccessfully, otherwise `null`.
  Future checkUserSubscribe({required int id}) async {
    return await apiClient.checkSubscribe(id);
  }

  /// This method is used to edit user information.
  ///
  /// [id] is the id of user.
  /// [name] is the name of user.
  /// [phoneNumber] is the phone number of user.
  /// [password] is the password of user.
  /// [email] is the email of user.
  /// [sex] is the sex of user.
  ///
  /// Return a [Future] that contains a [Map] with the following keys:
  /// - `status`: `true` if edit user successfully, otherwise `false`.
  /// - `error`: `String` if edit user unsuccessfully, otherwise `null`.
  Future editUserInfo({
    required int id,
    required String name,
    required String phoneNumber,
    required String email,
    required String password,
    required int sex,
  }) async {
    return await apiClient.editUser(
        id, name, phoneNumber, email, password, sex);
  }

  /// This method is used to get books of user.
  ///
  /// [id] is the id of user.
  ///
  /// Return a [Future] that contains a [Map] with the following keys:
  /// - `status`: `true` if get user books successfully, otherwise `false`.
  /// - `books`: `List<Book>` if get user books successfully, otherwise `null`.
  /// - `error`: `String` if get user books unsuccessfully, otherwise `null`.
  Future getMyBooks({required int id}) async {
    return await apiClient.getMyBooks(id);
  }

  /// This method is used to get books purchased by the user.
  ///
  /// [id] is the id of user.
  ///
  /// Return a [Future] that contains a [Map] with the following keys:
  /// - `status`: `true` if get user books successfully, otherwise `false`.
  /// - `books`: `List<Book>` if get user books successfully, otherwise `null`.
  /// - `error`: `String` if get user books unsuccessfully, otherwise `null`.
  Future getBuyBooks({required int id})async{
    return await apiClient.getBuyBooks(id);
  }
}
