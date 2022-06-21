import 'package:json_annotation/json_annotation.dart';

part 'category_model.g.dart';

@JsonSerializable()
class BookCategory {
  final String id;
  final String name;
  final String icon;

  BookCategory({
    required this.id,
    required this.name,
    required this.icon,
  });

  factory BookCategory.fromJson(Map<String, dynamic> json) => _$BookCategoryFromJson(json);

  Map<String, dynamic> toJson() => _$BookCategoryToJson(this);

  @override
  String toString() => 'BookCategory(id: $id, name: $name, image: $icon)';
}
