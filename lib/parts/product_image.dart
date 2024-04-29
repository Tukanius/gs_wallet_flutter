part of '../models/product_image.dart';

ProductImage _$ProductImageFromJson(Map<String, dynamic> json) {
  return ProductImage(
    id: json['_id'] != null ? json['_id'] as String : null,
    image: json['image'] != null ? json['image'] as String : null,
    sort: json['sort'] != null ? json['sort'] as int : null,
    createdAt: json['createdAt'] != null ? json['createdAt'] as String : null,
    updatedAt: json['updatedAt'] != null ? json['updatedAt'] as String : null,
  );
}

Map<String, dynamic> _$ProductImageToJson(ProductImage instance) {
  Map<String, dynamic> json = {};
  if (instance.id != null) json['_id'] = instance.id;
  if (instance.image != null) json['image'] = instance.image;
  if (instance.sort != null) json['sort'] = instance.sort;
  if (instance.createdAt != null) json['createdAt'] = instance.createdAt;
  if (instance.updatedAt != null) json['updatedAt'] = instance.updatedAt;

  return json;
}
