// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'slider_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookSlider _$SliderFromJson(Map<String, dynamic> json) => BookSlider(
      id: json['id'] as String,
      image: json['image'] as String,
      bookId: json['bookid'] as String,
      model: json['model'] as String,
      url: json['url'] as String?,
    );

Map<String, dynamic> _$SliderToJson(BookSlider instance) => <String, dynamic>{
      'id': instance.id,
      'image': instance.image,
      'bookid': instance.bookId,
      'model': instance.model,
      'url': instance.url,
    };
