import 'package:json_annotation/json_annotation.dart';

part 'category_model.g.dart';

@JsonSerializable()
class BookCategory {
  final int id;
  final String name;
  final String icon;
  final String slug;

  BookCategory({
    required this.id,
    required this.name,
    required this.icon,
    required this.slug,
  });

  factory BookCategory.fromJson(Map<String, dynamic> json) => _$BookCategoryFromJson(json);

  Map<String, dynamic> toJson() => _$BookCategoryToJson(this);

  @override
  String toString() => 'BookCategory(id: $id, name: $name, image: $icon)';
}
