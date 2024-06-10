part of '../models/order.dart';

Order _$OrderFromJson(Map<String, dynamic> json) {
  return Order(
    id: json['_id'] != null ? json['_id'] as String : null,
    iv: json['iv'] != null ? json['iv'] as String : null,
    // merchant: json['merchant'] != null ? json['merchant'] as String : null,
    code: json['code'] != null ? json['code'] as String : null,
    type: json['type'] != null ? json['type'] as String : null,
    paymentMethod:
        json['paymentMethod'] != null ? json['paymentMethod'] as String : null,
    qrcode: json['qrcode'] != null ? json['qrcode'] as String : null,
    totalAmount:
        json['totalAmount'] != null ? json['totalAmount'] as int : null,
    cashAmount: json['cashAmount'] != null ? json['cashAmount'] as int : null,
    cardAmount: json['cardAmount'] != null ? json['cardAmount'] as int : null,
    payAmount: json['payAmount'] != null ? json['payAmount'] as int : null,
    saleTokenAmount:
        json['saleTokenAmount'] != null ? json['saleTokenAmount'] as int : null,
    isSale: json['isSale'] != null ? json['isSale'] as bool : null,
    orderStatus:
        json['orderStatus'] != null ? json['orderStatus'] as String : null,
    orderStatusDate: json['orderStatusDate'] != null
        ? json['orderStatusDate'] as String
        : null,
    createdAt: json['createdAt'] != null ? json['createdAt'] as String : null,
    updatedAt: json['updatedAt'] != null ? json['updatedAt'] as String : null,
  );
}

Map<String, dynamic> _$OrderToJson(Order instance) {
  Map<String, dynamic> json = {};
  if (instance.id != null) json['_id'] = instance.id;
  if (instance.iv != null) json['iv'] = instance.iv;
  // if (instance.merchant != null) json['merchant'] = instance.merchant;

  if (instance.code != null) json['code'] = instance.code;
  if (instance.type != null) json['type'] = instance.type;
  if (instance.paymentMethod != null)
    json['paymentMethod'] = instance.paymentMethod;
  if (instance.qrcode != null) json['qrcode'] = instance.qrcode;
  if (instance.totalAmount != null) json['totalAmount'] = instance.totalAmount;
  if (instance.cashAmount != null) json['cashAmount'] = instance.cashAmount;
  if (instance.cardAmount != null) json['cardAmount'] = instance.cardAmount;
  if (instance.payAmount != null) json['payAmount'] = instance.payAmount;
  if (instance.saleTokenAmount != null)
    json['saleTokenAmount'] = instance.saleTokenAmount;
  if (instance.isSale != null) json['isSale'] = instance.isSale;
  if (instance.orderStatus != null) json['orderStatus'] = instance.orderStatus;
  if (instance.orderStatusDate != null)
    json['orderStatusDate'] = instance.orderStatusDate;
  if (instance.createdAt != null) json['createdAt'] = instance.createdAt;
  if (instance.updatedAt != null) json['updatedAt'] = instance.updatedAt;

  return json;
}
