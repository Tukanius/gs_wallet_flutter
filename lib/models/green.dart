part '../parts/green.dart';

class Green {
  String? id;
  String? type;
  String? name;
  String? description;
  String? code;
  String? unit;
  int? threshold;
  num? scoreAmount;
  String? createdAt;
  String? updatedAt;

  Green({
    this.type,
    this.id,
    this.name,
    this.unit,
    this.code,
    this.description,
    this.threshold,
    this.createdAt,
    this.updatedAt,
    this.scoreAmount,
  });

  static $fromJson(Map<String, dynamic> json) => _$GreenFromJson(json);

  factory Green.fromJson(Map<String, dynamic> json) => _$GreenFromJson(json);
  Map<String, dynamic> toJson() => _$GreenToJson(this);
}
