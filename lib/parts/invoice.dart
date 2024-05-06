part of '../models/invoice.dart';

Invoice _$InvoiceFromJson(Map<String, dynamic> json) {
  return Invoice(
    amount: json['amount'] != null ? json['amount'] as int : null,
    paymentMethod:
        json['paymentMethod'] != null ? json['paymentMethod'] as String : null,
    id: json['_id'] != null ? json['_id'] as String : null,
    user: json['user'] != null ? json['user'] as String : null,
    invoice: json['invoice'] != null ? json['invoice'] as String : null,
    method: json['method'] != null ? json['method'] as String : null,
    currency: json['currency'] != null ? json['currency'] as String : null,
    description:
        json['description'] != null ? json['description'] as String : null,
    paymentStatus:
        json['paymentStatus'] != null ? json['paymentStatus'] as String : null,
    paymentStatusDate: json['paymentStatusDate'] != null
        ? json['paymentStatusDate'] as String
        : null,
    createdAt: json['createdAt'] != null ? json['createdAt'] as String : null,
    updatedAt: json['updatedAt'] != null ? json['updatedAt'] as String : null,
  );
}

Map<String, dynamic> _$InvoiceToJson(Invoice instance) {
  Map<String, dynamic> json = {};

  if (instance.amount != null) json['amount'] = instance.amount;
  if (instance.paymentMethod != null)
    json['paymentMethod'] = instance.paymentMethod;
  if (instance.id != null) json['_id'] = instance.id;
  if (instance.user != null) json['user'] = instance.user;
  if (instance.invoice != null) json['invoice'] = instance.invoice;
  if (instance.method != null) json['method'] = instance.method;
  if (instance.currency != null) json['currency'] = instance.currency;
  if (instance.description != null) json['description'] = instance.description;
  if (instance.paymentStatus != null)
    json['paymentStatus'] = instance.paymentStatus;
  if (instance.paymentStatusDate != null)
    json['paymentStatusDate'] = instance.paymentStatusDate;
  if (instance.createdAt != null) json['createdAt'] = instance.createdAt;
  if (instance.updatedAt != null) json['updatedAt'] = instance.updatedAt;

  return json;
}
