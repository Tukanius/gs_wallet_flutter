part of '../models/history.dart';

History _$HistoryFromJson(Map<String, dynamic> json) {
  return History(
    id: json['_id'] != null ? json['_id'] as String : null,
    amount: json['amount'] != null ? json['amount'] as num : null,
    type: json['type'] != null ? json['type'] as String : null,
    objectId: json['objectId'] != null ? json['objectId'] as String : null,
    objectType:
        json['objectType'] != null ? json['objectType'] as String : null,
    totalAmount:
        json['totalAmount'] != null ? json['totalAmount'] as num : null,
    tokenAmount:
        json['tokenAmount'] != null ? json['tokenAmount'] as num : null,
    currency: json['currency'] != null ? json['currency'] as String : null,
    description:
        json['description'] != null ? json['description'] as String : null,
    creditAccount:
        json['creditAccount'] != null ? json['creditAccount'] as String : null,
    creditAccountName: json['creditAccountName'] != null
        ? json['creditAccountName'] as String
        : null,
    creditAccountCurrency: json['creditAccountCurrency'] != null
        ? json['creditAccountCurrency'] as String
        : null,
    debitAccount:
        json['debitAccount'] != null ? json['debitAccount'] as String : null,
    debitAccountName: json['debitAccountName'] != null
        ? json['debitAccountName'] as String
        : null,
    debitAccountCurrency: json['debitAccountCurrency'] != null
        ? json['debitAccountCurrency'] as String
        : null,
    transactionStatus: json['transactionStatus'] != null
        ? json['transactionStatus'] as String
        : null,
    transactionStatusDate: json['transactionStatusDate'] != null
        ? json['transactionStatusDate'] as String
        : null,
    createdAt: json['createdAt'] != null ? json['createdAt'] as String : null,
    updatedAt: json['updatedAt'] != null ? json['updatedAt'] as String : null,
  );
}

Map<String, dynamic> _$HistoryToJson(History instance) {
  Map<String, dynamic> json = {};

  if (instance.id != null) json['_id'] = instance.id;
  if (instance.type != null) json['type'] = instance.type;
  if (instance.objectId != null) json['objectId'] = instance.objectId;
  if (instance.objectType != null) json['objectType'] = instance.objectType;
  if (instance.amount != null) json['amount'] = instance.amount;
  if (instance.totalAmount != null) json['totalAmount'] = instance.totalAmount;
  if (instance.currency != null) json['currency'] = instance.currency;
  if (instance.description != null) json['description'] = instance.description;
  if (instance.creditAccount != null)
    json['creditAccount'] = instance.creditAccount;
  if (instance.creditAccountName != null)
    json['creditAccountName'] = instance.creditAccountName;
  if (instance.creditAccountCurrency != null)
    json['creditAccountCurrency'] = instance.creditAccountCurrency;
  if (instance.debitAccount != null)
    json['debitAccount'] = instance.debitAccount;
  if (instance.debitAccountName != null)
    json['debitAccountName'] = instance.debitAccountName;
  if (instance.debitAccountCurrency != null)
    json['debitAccountCurrency'] = instance.debitAccountCurrency;
  if (instance.transactionStatus != null)
    json['transactionStatus'] = instance.transactionStatus;
  if (instance.transactionStatusDate != null)
    json['transactionStatusDate'] = instance.transactionStatusDate;
  if (instance.createdAt != null) json['createdAt'] = instance.createdAt;
  if (instance.updatedAt != null) json['updatedAt'] = instance.updatedAt;
  if (instance.tokenAmount != null) json['tokenAmount'] = instance.tokenAmount;

  return json;
}
