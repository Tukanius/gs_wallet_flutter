part '../parts/accumlation.dart';

class Accumlation {
  String? id;
  String? user;
  String? type;
  String? unit;
  String? amount;
  num? balanceAmount;
  num? holdAmount;
  String? createdAt;
  String? updatedAt;
  num? latitude;
  num? longitude;

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
  });
  static $fromJson(Map<String, dynamic> json) => _$AccumlationFromJson(json);

  factory Accumlation.fromJson(Map<String, dynamic> json) =>
      _$AccumlationFromJson(json);
  Map<String, dynamic> toJson() => _$AccumlationToJson(this);
}
