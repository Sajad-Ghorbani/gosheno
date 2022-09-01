// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activity_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Activity _$ActivityFromJson(Map<String, dynamic> json) => Activity(
  id: json['id'] as int,
  text: json['text'] as String,
  bookId: json['book_id'] as String,
  rate: json['rate'] as String,
  stat: json['stat'] as String,
  time: json['time'] as String,
  uid: json['uid'] as String,
);

Map<String, dynamic> _$ActivityToJson(Activity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'text': instance.text,
      'book_id': instance.bookId,
      'rate': instance.rate,
      'stat': instance.stat,
      'time': instance.time,
      'uid': instance.uid,
    };
