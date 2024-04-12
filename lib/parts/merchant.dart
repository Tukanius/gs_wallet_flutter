part of '../models/merchant.dart';

Merchant _$MerchantFromJson(Map<String, dynamic> json) {
  return Merchant(
    id: json['_id'] != null ? json['_id'] as String : null,
    name: json['name'] != null ? json['name'] as String : null,
    phone: json['phone'] != null ? json['phone'] as String : null,
    address: json['address'] != null ? json['address'] as String : null,
    registerNo:
        json['registerNo'] != null ? json['registerNo'] as String : null,
    email: json['email'] != null ? json['email'] as String : null,
    balance: json['balance'] != null ? json['balance'] as int : null,
    merchantStatus: json['merchantStatus'] != null
        ? json['merchantStatus'] as String
        : null,
    merchantStatusDate: json['merchantStatusDate'] != null
        ? json['merchantStatusDate'] as String
        : null,
    createdAt: json['createdAt'] != null ? json['createdAt'] as String : null,
    updatedAt: json['updatedAt'] != null ? json['updatedAt'] as String : null,
  );
}

Map<String, dynamic> _$MerchantToJson(Merchant instance) {
  Map<String, dynamic> json = {};
  if (instance.id != null) json['_id'] = instance.id;
  if (instance.name != null) json['name'] = instance.name;
  if (instance.phone != null) json['phone'] = instance.phone;
  if (instance.address != null) json['address'] = instance.address;
  if (instance.registerNo != null) json['registerNo'] = instance.registerNo;
  if (instance.email != null) json['email'] = instance.email;
  if (instance.balance != null) json['balance'] = instance.balance;
  if (instance.createdAt != null) json['createdAt'] = instance.createdAt;
  if (instance.updatedAt != null) json['updatedAt'] = instance.updatedAt;
  if (instance.merchantStatus != null)
    json['merchantStatus'] = instance.merchantStatus;
  if (instance.merchantStatusDate != null)
    json['merchantStatusDate'] = instance.merchantStatusDate;

  return json;
}
