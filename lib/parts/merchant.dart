part of '../models/merchant.dart';

Merchant _$MerchantFromJson(Map<String, dynamic> json) {
  return Merchant(
    id: json['_id'] != null ? json['_id'] as String : null,
    type: json['type'] != null ? json['type'] as String : null,
    name: json['name'] != null ? json['name'] as String : null,
    image: json['image'] != null
        ? Images.fromJson(json['image'] as Map<String, dynamic>)
        : null,
    taxNo: json['taxNo'] != null ? json['taxNo'] as String : null,
    phoneSecond:
        json['phoneSecond'] != null ? json['phoneSecond'] as String : null,
    phone: json['phone'] != null ? json['phone'] as String : null,
    address: json['address'] != null ? json['address'] as String : null,
    latitude: json['latitude'] != null ? json['latitude'] as double : null,
    longitude: json['longitude'] != null ? json['longitude'] as double : null,
    links: json['links'] != null
        ? (json['links'] as List).map((e) => Links.fromJson(e)).toList()
        : null,
    registerNo:
        json['registerNo'] != null ? json['registerNo'] as String : null,
    email: json['email'] != null ? json['email'] as String : null,
    createdAt: json['createdAt'] != null ? json['createdAt'] as String : null,
    updatedAt: json['updatedAt'] != null ? json['updatedAt'] as String : null,
  );
}

Map<String, dynamic> _$MerchantToJson(Merchant instance) {
  Map<String, dynamic> json = {};
  if (instance.id != null) json['_id'] = instance.id;
  if (instance.name != null) json['name'] = instance.name;
  if (instance.type != null) json['type'] = instance.type;
  if (instance.taxNo != null) json['taxNo'] = instance.taxNo;
  if (instance.phoneSecond != null) json['phoneSecond'] = instance.phoneSecond;
  if (instance.latitude != null) json['latitude'] = instance.latitude;
  if (instance.longitude != null) json['longitude'] = instance.longitude;
  if (instance.image != null) json['image'] = instance.image;
  if (instance.phone != null) json['phone'] = instance.phone;
  if (instance.address != null) json['address'] = instance.address;
  if (instance.registerNo != null) json['registerNo'] = instance.registerNo;
  if (instance.email != null) json['email'] = instance.email;
  if (instance.createdAt != null) json['createdAt'] = instance.createdAt;
  if (instance.updatedAt != null) json['updatedAt'] = instance.updatedAt;
  return json;
}
