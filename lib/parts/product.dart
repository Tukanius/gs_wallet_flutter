part of '../models/product.dart';

Product _$ProductFromJson(Map<String, dynamic> json) {
  return Product(
    id: json['_id'] != null ? json['_id'] as String : null,
    name: json['name'] != null ? json['name'] as String : null,
    code: json['code'] != null ? json['code'] as String : null,
    barcode: json['barcode'] != null ? json['barcode'] as String : null,
    price: json['price'] != null ? json['price'] as int : null,
    description:
        json['description'] != null ? json['description'] as String : null,
    createdAt: json['createdAt'] != null ? json['createdAt'] as String : null,
    updatedAt: json['updatedAt'] != null ? json['updatedAt'] as String : null,
    images: json['images'] != null
        ? (json['images'] as List).map((e) => Images.fromJson(e)).toList()
        : null,
    // merchant: json['merchant'] != null
    //     ? (json['merchant'] as List).map((e) => Merchant.fromJson(e)).toList()
    //     : null,

    sale: json['sale'] != null ? new Sale.fromJson(json['sale']) : null,
    saleProduct: json['saleProduct'] != null
        ? new SaleProduct.fromJson(json['saleProduct'])
        : null,
  );
}

Map<String, dynamic> _$ProductToJson(Product instance) {
  Map<String, dynamic> json = {};
  if (instance.id != null) json['_id'] = instance.id;
  if (instance.name != null) json['name'] = instance.name;
  if (instance.code != null) json['code'] = instance.code;
  if (instance.barcode != null) json['barcode'] = instance.barcode;
  if (instance.description != null) json['description'] = instance.description;
  if (instance.price != null) json['price'] = instance.price;
  if (instance.createdAt != null) json['createdAt'] = instance.createdAt;
  if (instance.updatedAt != null) json['updatedAt'] = instance.updatedAt;
  if (instance.images != null) json['images'] = instance.images;
  if (instance.sale != null) json['sale'] = instance.sale;
  if (instance.saleProduct != null) json['saleProduct'] = instance.saleProduct;

  return json;
}
