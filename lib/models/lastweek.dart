part '../parts/lastweek.dart';

class LastWeek {
  String? day;
  num? totalAmount;

  LastWeek({
    this.day,
    this.totalAmount,
  });

  static $fromJson(Map<String, dynamic> json) => _$LastWeekFromJson(json);

  factory LastWeek.fromJson(Map<String, dynamic> json) =>
      _$LastWeekFromJson(json);
  Map<String, dynamic> toJson() => _$LastWeekToJson(this);
}
