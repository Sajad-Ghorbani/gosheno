// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coupon_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Coupon _$CouponFromJson(Map<String, dynamic> json) => Coupon(
      id: json['id'] as int,
      name: json['name'] as String,
      val: json['val'] as String,
      content: json['content'] as String,
      expireAt: json['expire_at'] as String,
    );

Map<String, dynamic> _$CouponToJson(Coupon instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'val': instance.val,
      'content': instance.content,
      'expire_at': instance.expireAt,
    };
