import 'package:json_annotation/json_annotation.dart';

part 'book_model.g.dart';

@JsonSerializable()
class Book {
  int id;
  String name;
  String enName;
  String author;
  String? content;
  String? bookLink;
  String? soundLink;
  String? soundDemo;
  String short;
  String about;
  String cat;
  String price;
  String? sPrice;
  String pic;
  String authorContent;
  String? tId;
  String shows;
  String rate;
  String? admin;
  String? createdAt;
  String? updatedAt;

  Book({
    required this.id,
    required this.name,
    required this.enName,
    required this.author,
    this.content,
    this.bookLink,
    this.soundLink,
    this.soundDemo,
    required this.short,
    required this.about,
    required this.cat,
    required this.price,
    this.sPrice,
    required this.pic,
    required this.authorContent,
    this.tId,
    required this.shows,
    required this.rate,
    this.admin,
    this.createdAt,
    this.updatedAt,
  });

  factory Book.fromJson(Map<String, dynamic> json) => _$BookFromJson(json);

  Map<String, dynamic> toJson() => _$BookToJson(this);

  int get offCount {
    if (sPrice == null || sPrice == '0' || sPrice == '' || sPrice == '0.0') {
      return 0;
    } //
    else {
      int p = int.parse(price);
      int sP = int.parse(sPrice!);
      int off = 100 - ((sP * 100) ~/ p);
      return off;
    }
  }

  @override
  String toString() =>
      'Book(id: $id, name: $name, enName: $enName, author: $author, content: $content, bookLink: $bookLink, soundLink: $soundLink, short: $short, about: $about, cat: $cat, pic: $pic, authorContent: $authorContent, tId: $tId, shows: $shows, rate: $rate)';
}
