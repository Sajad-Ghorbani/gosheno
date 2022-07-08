// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Book _$BookFromJson(Map<String, dynamic> json) => Book(
      id: json['id'] as String,
      name: json['name'] as String,
      enName: json['en_name'] as String,
      author: json['author'] as String,
      content: json['content'] as String?,
      bookLink: json['book_link'] as String?,
      soundLink: json['sound_link'] as String?,
      soundDemo: json['sound_demo'] as String,
      short: json['short'] as String,
      about: json['about'] as String,
      cat: json['cat'] as String,
      price: json['price'] as String,
      sPrice: json['sprice'] as String,
      pic: json['pic'] as String,
      authorContent: json['author_content'] as String,
      ages: json['ages'] as String,
      tId: json['t_id'] as String,
      shows: json['shows'] as String,
      rate: json['rate'] as String,
    );

Map<String, dynamic> _$BookToJson(Book instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'en_name': instance.enName,
      'author': instance.author,
      'content': instance.content,
      'book_link': instance.bookLink,
      'sound_link': instance.soundLink,
      'sound_demo': instance.soundDemo,
      'short': instance.short,
      'about': instance.about,
      'cat': instance.cat,
      'price': instance.price,
      'sprice': instance.sPrice,
      'pic': instance.pic,
      'author_content': instance.authorContent,
      'ages': instance.ages,
      't_id': instance.tId,
      'shows': instance.shows,
      'rate': instance.rate,
    };
