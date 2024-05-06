part of '../models/sale.dart';

Sale _$SaleFromJson(Map<String, dynamic> json) {
  return Sale(
    id: json['_id'] != null ? json['_id'] as String : null,
    merchant: json['merchant'] != null ? json['merchant'] as String : null,
    type: json['type'] != null ? json['type'] as String : null,
    name: json['name'] != null ? json['name'] as String : null,
    description:
        json['description'] != null ? json['description'] as String : null,
    image: json['image'] != null ? json['image'] as String : null,
    address: json['address'] != null ? json['address'] as String : null,
    phone: json['phone'] != null ? json['phone'] as String : null,
    phoneSecond:
        json['phoneSecond'] != null ? json['phoneSecond'] as String : null,
    links: json['links'] != null
        ? (json['links'] as List).map((e) => Links.fromJson(e)).toList()
        : null,
    latitude: json['latitude'] != null ? json['latitude'] as double : null,
    longitude: json['longitude'] != null ? json['longitude'] as double : null,
    isExpirity: json['isExpirity'] != null ? json['isExpirity'] as bool : null,
    expiryDate:
        json['expiryDate'] != null ? json['expiryDate'] as String : null,
    saleAmount: json['saleAmount'] != null ? json['saleAmount'] as int : null,
    saleTokenAmount: json['saleTokenAmount'] != null
        ? json['saleTokenAmount'] as double
        : null,
    createdAt: json['createdAt'] != null ? json['createdAt'] as String : null,
    updatedAt: json['updatedAt'] != null ? json['updatedAt'] as String : null,
  );
}

Map<String, dynamic> _$SaleToJson(Sale instance) {
  Map<String, dynamic> json = {};
  if (instance.id != null) json['_id'] = instance.id;
  if (instance.address != null) json['address'] = instance.address;
  if (instance.description != null) json['description'] = instance.description;
  if (instance.expiryDate != null) json['expiryDate'] = instance.expiryDate;
  if (instance.image != null) json['image'] = instance.image;
  if (instance.isExpirity != null) json['isExpirity'] = instance.isExpirity;
  if (instance.latitude != null) json['latitude'] = instance.latitude;
  if (instance.links != null) json['links'] = instance.links;
  if (instance.longitude != null) json['longitude'] = instance.longitude;
  if (instance.merchant != null) json['merchant'] = instance.merchant;
  if (instance.phone != null) json['phone'] = instance.phone;
  if (instance.phoneSecond != null) json['phoneSecond'] = instance.phoneSecond;
  if (instance.saleAmount != null) json['saleAmount'] = instance.saleAmount;
  if (instance.saleTokenAmount != null)
    json['saleTokenAmount'] = instance.saleTokenAmount;
  if (instance.type != null) json['type'] = instance.type;
  if (instance.createdAt != null) json['createdAt'] = instance.createdAt;
  if (instance.updatedAt != null) json['updatedAt'] = instance.updatedAt;

  return json;
}
