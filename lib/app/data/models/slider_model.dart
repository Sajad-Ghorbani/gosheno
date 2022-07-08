import 'package:json_annotation/json_annotation.dart';

part 'slider_model.g.dart';

@JsonSerializable()
class BookSlider {
  String id;
  String image;
  String bookId;
  String model;
  String? url;

  BookSlider({
    required this.id,
    required this.image,
    required this.bookId,
    required this.model,
    this.url,
  });

  factory BookSlider.fromJson(Map<String, dynamic> json) => _$SliderFromJson(json);

  Map<String, dynamic> toJson() => _$SliderToJson(this);

  @override
  String toString() => 'Slider(id: $id, title: $url, description: $bookId, image: $image, model: $model)';
}
