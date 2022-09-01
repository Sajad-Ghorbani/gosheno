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
  /// - `user`: `User` if the user is registered successfully, otherwise `null`.
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
  /// - `user`: `User` if the user is logged in successfully, otherwise `null`.
  /// - `error`: `String` if the user is not logged in successfully, otherwise `null`.
  Future loginUser({
    required String phoneNumber,
    required String pass,
  }) async {
    return await apiClient.loginUser(phoneNumber, pass);
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
  Future getUserInfo({required int id}) async {
    return await apiClient.getUser(id);
  }

  /// This method is used to check user subscribe.
  ///
  /// [id] is the id of user.
  ///
  /// Returns a [Future] that contains a [Map] with the following keys:
  /// - `status`: `true` if check user subscribe successfully, otherwise `false`.
  /// - `subscribe`: `int` if check user subscribe successfully, otherwise `null`.
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
  /// - `message`: `String` if edit user successfully, otherwise `null`.
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

  /// This method is used to reset password.
  ///
  /// [phoneNumber] is the phone number of user.
  ///
  /// Return a [Future] that contains a [Map] with the following keys:
  /// - `status`: `true` if reset password successfully, otherwise `false`.
  /// - `code`: `String` if reset password successfully, otherwise `null`.
  /// - `error`: `String` if reset password unsuccessfully, otherwise `null`.
  Future resetPassword({required String phoneNumber}) async {
    return await apiClient.resetPassword(phoneNumber);
  }

  /// This method is used to confirm password.
  ///
  /// [phoneNumber] is the phone number of user.
  ///
  /// Return a [Future] that contains a [Map] with the following keys:
  /// - `status`: `true` if confirm password successfully, otherwise `false`.
  /// - `error`: `String` if confirm password unsuccessfully, otherwise `null`.
  Future confirmPassword({required String phoneNumber}) async {
    return await apiClient.confirmPassword(phoneNumber);
  }

  /// This method is used to get coupons.
  ///
  /// Return a [Future] that contains a [Map] with the following keys:
  /// - `status`: `true` if get coupons successfully, otherwise `false`.
  /// - `coupons`: `List<Coupon>` if get coupons successfully, otherwise `null`.
  /// - `error`: `String` if get coupons unsuccessfully, otherwise `null`.
  Future getCoupons() async {
    return await apiClient.getCoupons();
  }

  /// This method is used to get user activities.
  ///
  /// [id] is the id of user.
  ///
  /// Return a [Future] that contains a [Map] with the following keys:
  /// - `status`: `true` if get user activities successfully, otherwise `false`.
  /// - `activities`: `List<Activity>` if get user activities successfully, otherwise `null`.
  /// - `error`: `String` if get user activities unsuccessfully, otherwise `null`.
  Future getUserActivities({required int id}) async {
    return await apiClient.getUserActivities(id);
  }

  /// This method is used to check user email exist.
  ///
  /// [email] is the email of user.
  ///
  /// Returns a [Future] that contains a [Map] with the following keys:
  /// - `status`: `true` if check user email exist successfully, otherwise `false`.
  /// - `id`: `int` if check user email exist successfully, otherwise `null`.
  Future checkUserEmailExist({required String email}) async {
    return await apiClient.existUserEmail(email);
  }
}
