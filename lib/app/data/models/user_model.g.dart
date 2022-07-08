// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      name: json['name'] as String,
      mobile: json['mobile'] as String,
      email: json['email'] as String?,
      sex: json['sex'] as String?,
      wallet: json['wallet'] as String?,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'mobile': instance.mobile,
      'password': instance.password,
      'email': instance.email,
      'sex': instance.sex,
      'wallet': instance.wallet,
    };
