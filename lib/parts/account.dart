part of '../models/account.dart';

Account _$AccountFromJson(Map<String, dynamic> json) {
  return Account(
    id: json['_id'] != null ? json['_id'] as String : null,
    ownerType: json['ownerType'] != null ? json['ownerType'] as String : null,
    type: json['type'] != null ? json['type'] as String : null,
    code: json['code'] != null ? json['code'] as String : null,
    name: json['name'] != null ? json['name'] as String : null,
    qrCode: json['qrCode'] != null ? json['qrCode'] as String : null,
    currency: json['currency'] != null ? json['currency'] as String : null,
    pubKey: json['pubKey'] != null ? json['pubKey'] as String : null,
    txHash: json['txHash'] != null ? json['txHash'] as String : null,
    balanceAmount:
        json['balanceAmount'] != null ? json['balanceAmount'] as int : null,
    holdAmount: json['holdAmount'] != null ? json['holdAmount'] as int : null,
    createdAt: json['createdAt'] != null ? json['createdAt'] as String : null,
    updatedAt: json['updatedAt'] != null ? json['updatedAt'] as String : null,
  );
}

Map<String, dynamic> _$AccountToJson(Account instance) {
  Map<String, dynamic> json = {};
  if (instance.id != null) json['_id'] = instance.id;
  if (instance.ownerType != null) json['ownerType'] = instance.ownerType;
  if (instance.type != null) json['type'] = instance.type;
  if (instance.code != null) json['code'] = instance.code;
  if (instance.name != null) json['name'] = instance.name;
  if (instance.qrCode != null) json['qrCode'] = instance.qrCode;
  if (instance.currency != null) json['currency'] = instance.currency;
  if (instance.pubKey != null) json['pubKey'] = instance.pubKey;
  if (instance.txHash != null) json['txHash'] = instance.txHash;
  if (instance.balanceAmount != null)
    json['balanceAmount'] = instance.balanceAmount;
  if (instance.holdAmount != null) json['holdAmount'] = instance.holdAmount;
  if (instance.createdAt != null) json['createdAt'] = instance.createdAt;
  if (instance.updatedAt != null) json['updatedAt'] = instance.updatedAt;

  return json;
}
