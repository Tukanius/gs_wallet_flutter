import 'package:green_score/models/lastweek.dart';
part '../parts/accumlation.dart';

class Accumlation {
  String? id;
  String? user;
  String? type;
  String? unit;
  String? amount;
  int? balanceAmount;
  int? holdAmount;
  String? createdAt;
  String? updatedAt;
  num? latitude;
  num? longitude;
  String? code;
  List<LastWeek>? lastWeekTotal;
  bool? isRedeem;

  Accumlation({
    this.id,
    this.type,
    this.balanceAmount,
    this.unit,
    this.amount,
    this.user,
    this.holdAmount,
    this.createdAt,
    this.updatedAt,
    this.latitude,
    this.longitude,
    this.code,
    this.lastWeekTotal,
    this.isRedeem,
  });
  static $fromJson(Map<String, dynamic> json) => _$AccumlationFromJson(json);

  factory Accumlation.fromJson(Map<String, dynamic> json) =>
      _$AccumlationFromJson(json);
  Map<String, dynamic> toJson() => _$AccumlationToJson(this);
}
