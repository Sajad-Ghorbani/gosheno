import 'package:json_annotation/json_annotation.dart';

part 'comment_model.g.dart';

@JsonSerializable()
class BookComment{
  String id;
  String text;
  String bookId;
  String rate;
  String stat;

  BookComment({
    required this.id,
    required this.text,
    required this.bookId,
    required this.rate,
    required this.stat,
  });

  factory BookComment.fromJson(Map<String, dynamic> json)=> _$CommentFromJson(json);

  Map<String, dynamic> toJson()=> _$CommentToJson(this);

  @override
  String toString() {
    return 'Comment{id: $id, text: $text, bookId: $bookId, rate: $rate, state: $stat}';
  }
}