part of '../models/bank.dart';

Bank _$BankFromJson(Map<String, dynamic> json) {
  return Bank(
    // id: json['_id'] != null ? json['_id'] as String : null,
    // userId: json['userId'] != null ? json['userId'] as String : null,
    bankName: json['bankName'] != null ? json['bankName'] as String : null,
    bankAccount:
        json['bankAccount'] != null ? json['bankAccount'] as String : null,
    bankStatus:
        json['bankStatus'] != null ? json['bankStatus'] as String : null,
    createdAt: json['createdAt'] != null ? json['createdAt'] as String : null,
    updatedAt: json['updatedAt'] != null ? json['updatedAt'] as String : null,
  );
}

Map<String, dynamic> _$BankToJson(Bank instance) {
  Map<String, dynamic> json = {};
  // if (instance.id != null) json['_id'] = instance.id;
  // if (instance.userId != null) json['userId'] = instance.userId;
  if (instance.bankName != null) json['bankName'] = instance.bankName;
  if (instance.bankAccount != null) json['bankAccount'] = instance.bankAccount;
  if (instance.bankStatus != null) json['bankStatus'] = instance.bankStatus;
  if (instance.createdAt != null) json['createdAt'] = instance.createdAt;
  if (instance.updatedAt != null) json['updatedAt'] = instance.updatedAt;

  return json;
}
