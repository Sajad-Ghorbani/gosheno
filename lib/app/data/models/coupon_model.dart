import 'package:json_annotation/json_annotation.dart';

part 'coupon_model.g.dart';

@JsonSerializable()
class Coupon{
  int id;
  String name;
  String val;
  String content;
  String expireAt;

  Coupon({
    required this.id,
    required this.name,
    required this.val,
    required this.content,
    required this.expireAt,
  });

  factory Coupon.fromJson(Map<String, dynamic> json) => _$CouponFromJson(json);

  Map<String, dynamic> toJson() => _$CouponToJson(this);
}