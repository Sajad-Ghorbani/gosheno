import 'package:json_annotation/json_annotation.dart';

part 'slider_model.g.dart';

@JsonSerializable()
class BookSlider {
  int id;
  String name;
  String image;
  String bookId;
  String model;
  String? url;
  String? txt;

  BookSlider({
    required this.id,
    required this.name,
    required this.image,
    required this.bookId,
    required this.model,
    this.url,
    this.txt,
  });

  factory BookSlider.fromJson(Map<String, dynamic> json) => _$SliderFromJson(json);

  Map<String, dynamic> toJson() => _$SliderToJson(this);

  @override
  String toString() => 'Slider(id: $id, title: $url, description: $bookId, image: $image, model: $model)';
}
