// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookComment _$BookCommentFromJson(Map<String, dynamic> json) => BookComment(
      id: json['id'] as int,
      text: json['text'] as String,
      bookId: json['book_id'] as String,
      rate: json['rate'] as String,
      stat: json['stat'] as String,
      uId: json['uid'] as String,
      time: json['time'] as String,
    );

Map<String, dynamic> _$BookCommentToJson(BookComment instance) =>
    <String, dynamic>{
      'id': instance.id,
      'text': instance.text,
      'book_id': instance.bookId,
      'rate': instance.rate,
      'stat': instance.stat,
      'uid': instance.uId,
      'time': instance.time,
    };
