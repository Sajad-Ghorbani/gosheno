import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class User {
  int? id;
  String name;
  String? mobile;
  String? password;
  String? email;
  String? sex;
  String? wallet;
  String? subscribe;
  String? subscribeMonth;
  String? maxBook;

  User({
    this.id,
    required this.name,
    this.mobile,
    this.password,
    this.email,
    this.sex,
    this.wallet,
    this.subscribe,
    this.subscribeMonth,
    this.maxBook,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);

  @override
  toString()=>'{id: $id, name: $name, mobile: $mobile, password: $password, email: $email, sex: $sex, wallet: $wallet, sub: $subscribe, subMonth: $subscribeMonth, maxBook: $maxBook}';
}
