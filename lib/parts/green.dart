part of '../models/green.dart';

Green _$GreenFromJson(Map<String, dynamic> json) {
  return Green(
    id: json['_id'] != null ? json['_id'] as String : null,
    type: json['type'] != null ? json['type'] as String : null,
    name: json['name'] != null ? json['name'] as String : null,
    description:
        json['description'] != null ? json['description'] as String : null,
    code: json['code'] != null ? json['code'] as String : null,
    unit: json['unit'] != null ? json['unit'] as String : null,
    threshold: json['threshold'] != null ? json['threshold'] as int : null,
    scoreAmount:
        json['scoreAmount'] != null ? json['scoreAmount'] as num : null,
    createdAt: json['createdAt'] != null ? json['createdAt'] as String : null,
    updatedAt: json['updatedAt'] != null ? json['updatedAt'] as String : null,
  );
}

Map<String, dynamic> _$GreenToJson(Green instance) {
  Map<String, dynamic> json = {};

  if (instance.id != null) json['_id'] = instance.id;
  if (instance.type != null) json['type'] = instance.type;
  if (instance.name != null) json['name'] = instance.name;
  if (instance.description != null) json['description'] = instance.description;
  if (instance.code != null) json['code'] = instance.code;
  if (instance.unit != null) json['unit'] = instance.unit;
  if (instance.threshold != null) json['threshold'] = instance.threshold;
  if (instance.createdAt != null) json['createdAt'] = instance.createdAt;
  if (instance.updatedAt != null) json['updatedAt'] = instance.updatedAt;
  if (instance.scoreAmount != null) json['scoreAmount'] = instance.scoreAmount;

  return json;
}
