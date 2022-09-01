import 'package:json_annotation/json_annotation.dart';

part 'comment_model.g.dart';

@JsonSerializable()
class BookComment{
  int id;
  String text;
  String bookId;
  String rate;
  String stat;
  String uId;
  String time;

  BookComment({
    required this.id,
    required this.text,
    required this.bookId,
    required this.rate,
    required this.stat,
    required this.uId,
    required this.time,
  });

  factory BookComment.fromJson(Map<String, dynamic> json)=> _$BookCommentFromJson(json);

  Map<String, dynamic> toJson()=> _$BookCommentToJson(this);

  @override
  String toString() {
    return 'Comment{id: $id, text: $text, bookId: $bookId, rate: $rate, state: $stat}';
  }
}