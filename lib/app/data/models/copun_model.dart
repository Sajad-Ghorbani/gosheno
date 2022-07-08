import 'package:json_annotation/json_annotation.dart';

part 'copun_model.g.dart';

@JsonSerializable()
class Copun{
  String id;
  String name;
  String val;

  Copun({
    required this.id,
    required this.name,
    required this.val,
  });

  factory Copun.fromJson(Map<String, dynamic> json) => _$CopunFromJson(json);

  Map<String, dynamic> toJson() => _$CopunToJson(this);
}