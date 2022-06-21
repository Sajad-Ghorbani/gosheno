import 'package:json_annotation/json_annotation.dart';

part 'book_model.g.dart';

@JsonSerializable()
class Book {
  String id;
  String name;
  String enName;
  String author;
  String content;
  String bookLink;
  String soundLink;
  String? soundDemo;
  String short;
  String about;
  String cat;
  String price;
  String sPrice;
  String pic;
  String authorContent;
  String ages;
  String? tId;
  String? shows;
  String? rate;

  Book({
    required this.id,
    required this.name,
    required this.enName,
    required this.author,
    required this.content,
    required this.bookLink,
    required this.soundLink,
    this.soundDemo,
    required this.short,
    required this.about,
    required this.cat,
    required this.price,
    required this.sPrice,
    required this.pic,
    required this.authorContent,
    required this.ages,
    this.tId,
    this.shows,
    this.rate,
  });

  factory Book.fromJson(Map<String, dynamic> json) => _$BookFromJson(json);

  Map<String, dynamic> toJson() => _$BookToJson(this);

  int offCount() {
    if (sPrice == '0') {
      return 0;
    } //
    else {
      int p = int.parse(price);
      int sP = int.parse(sPrice);
      int off = 100 - ((sP * 100) ~/ p);
      return off;
    }
  }

  @override
  String toString() =>
      'Book(id: $id, name: $name, enName: $enName, author: $author, content: $content, bookLink: $bookLink, soundLink: $soundLink, short: $short, about: $about, cat: $cat, pic: $pic, authorContent: $authorContent, ages: $ages, tId: $tId, shows: $shows, rate: $rate)';
}
