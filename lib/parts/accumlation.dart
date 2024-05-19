part of '../models/accumlation.dart';

Accumlation _$AccumlationFromJson(Map<String, dynamic> json) {
  return Accumlation(
    id: json['_id'] != null ? json['_id'] as String : null,
    user: json['user'] != null ? json['user'] as String : null,
    type: json['type'] != null ? json['type'] as String : null,
    unit: json['unit'] != null ? json['unit'] as String : null,
    amount: json['amount'] != null ? json['amount'] as String : null,
    balanceAmount:
        json['balanceAmount'] != null ? json['balanceAmount'] as num : null,
    holdAmount: json['holdAmount'] != null ? json['holdAmount'] as num : null,
    latitude: json['latitude'] != null ? json['latitude'] as num : null,
    longitude: json['longitude'] != null ? json['longitude'] as num : null,
    createdAt: json['createdAt'] != null ? json['createdAt'] as String : null,
    updatedAt: json['updatedAt'] != null ? json['updatedAt'] as String : null,
  );
}

Map<String, dynamic> _$AccumlationToJson(Accumlation instance) {
  Map<String, dynamic> json = {};
  if (instance.id != null) json['_id'] = instance.id;

  if (instance.user != null) json['user'] = instance.user;
  if (instance.type != null) json['type'] = instance.type;
  if (instance.unit != null) json['unit'] = instance.unit;
  if (instance.amount != null) json['amount'] = instance.amount;
  if (instance.latitude != null) json['latitude'] = instance.latitude;
  if (instance.longitude != null) json['longitude'] = instance.longitude;

  if (instance.balanceAmount != null)
    json['balanceAmount'] = instance.balanceAmount;
  if (instance.holdAmount != null) json['holdAmount'] = instance.holdAmount;
  if (instance.createdAt != null) json['createdAt'] = instance.createdAt;
  if (instance.updatedAt != null) json['updatedAt'] = instance.updatedAt;

  return json;
}
