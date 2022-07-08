import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class User {
  int? id;
  String name;
  String mobile;
  String? password;
  String? email;
  String? sex;
  String? wallet;

  User({
    this.id,
    required this.name,
    required this.mobile,
    this.password,
    this.email,
    this.sex,
    this.wallet,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
