import 'package:json_annotation/json_annotation.dart';

part 'activity_model.g.dart';

@JsonSerializable()
class Activity {
  int id;
  String text;
  String bookId;
  String rate;
  String stat;
  String time;
  String uid;

  Activity({
    required this.id,
    required this.text,
    required this.bookId,
    required this.rate,
    required this.stat,
    required this.time,
    required this.uid,
  });

  factory Activity.fromJson(Map<String, dynamic> json) => _$ActivityFromJson(json);

  Map<String, dynamic> toJson() => _$ActivityToJson(this);

  @override
  String toString() => 'Activity(id: $id, text: $text, bookId: $bookId, rate: $rate, stat: $stat, time: $time, uid: $uid)';
}
