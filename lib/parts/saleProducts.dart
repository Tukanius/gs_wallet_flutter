part of '../models/saleProducts.dart';

SaleProduct _$SaleProductFromJson(Map<String, dynamic> json) {
  return SaleProduct(
    id: json['_id'] != null ? json['_id'] as String : null,
    merchant: json['merchant'] != null ? json['merchant'] as String : null,
    sale: json['sale'] != null ? json['sale'] as String : null,
    name: json['name'] != null ? json['name'] as String : null,
    product: json['product'] != null ? json['product'] as String : null,
    saleAmount: json['saleAmount'] != null ? json['saleAmount'] as num : null,
    tokenAmount:
        json['tokenAmount'] != null ? json['tokenAmount'] as num : null,
    createdAt: json['createdAt'] != null ? json['createdAt'] as String : null,
    updatedAt: json['updatedAt'] != null ? json['updatedAt'] as String : null,
  );
}

Map<String, dynamic> _$SaleProductToJson(SaleProduct instance) {
  Map<String, dynamic> json = {};
  if (instance.id != null) json['_id'] = instance.id;
  if (instance.merchant != null) json['merchant'] = instance.merchant;
  if (instance.sale != null) json['sale'] = instance.sale;
  if (instance.name != null) json['name'] = instance.name;
  if (instance.product != null) json['product'] = instance.product;
  if (instance.saleAmount != null) json['saleAmount'] = instance.saleAmount;
  if (instance.tokenAmount != null) json['tokenAmount'] = instance.tokenAmount;
  if (instance.createdAt != null) json['createdAt'] = instance.createdAt;
  if (instance.updatedAt != null) json['updatedAt'] = instance.updatedAt;

  return json;
}
