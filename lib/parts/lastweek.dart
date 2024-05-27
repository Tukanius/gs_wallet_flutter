part of '../models/lastweek.dart';

LastWeek _$LastWeekFromJson(Map<String, dynamic> json) {
  return LastWeek(
    day: json['day'] != null ? json['day'] as String : null,
    totalAmount:
        json['totalAmount'] != null ? json['totalAmount'] as num : null,
  );
}

Map<String, dynamic> _$LastWeekToJson(LastWeek instance) {
  Map<String, dynamic> json = {};
  if (instance.day != null) json['day'] = instance.day;
  if (instance.totalAmount != null) json['totalAmount'] = instance.totalAmount;

  return json;
}
