part of '../models/product.dart';

Product _$ProductFromJson(Map<String, dynamic> json) {
  return Product(
    id: json['_id'] != null ? json['_id'] as String : null,
    publisherId:
        json['publisherId'] != null ? json['publisherId'] as String : null,
    name: json['name'] != null ? json['name'] as String : null,
    category: json['category'] != null ? json['category'] as String : null,
    price: json['price'] != null ? json['price'] as int : null,
    height: json['height'] != null ? json['height'] as String : null,
    isActive: json['isActive'] != null ? json['isActive'] as bool : null,
    size: json['size'] != null ? json['size'] as String : null,
    ram: json['ram'] != null ? json['ram'] as String : null,
    storage: json['storage'] != null ? json['storage'] as String : null,
    engine: json['engine'] != null ? json['engine'] as String : null,
    engineType:
        json['engineType'] != null ? json['engineType'] as String : null,
    transmission:
        json['transmission'] != null ? json['transmission'] as String : null,
    color: json['color'] != null ? json['color'] as String : null,
    releasedDate:
        json['releasedDate'] != null ? json['releasedDate'] as String : null,
    importedDate:
        json['importedDate'] != null ? json['importedDate'] as String : null,
    description:
        json['description'] != null ? json['description'] as String : null,
    productStatus:
        json['productStatus'] != null ? json['productStatus'] as String : null,
    productStatusDate: json['productStatusDate'] != null
        ? json['productStatusDate'] as String
        : null,
    createdAt: json['createdAt'] != null ? json['createdAt'] as String : null,
    updatedAt: json['updatedAt'] != null ? json['updatedAt'] as String : null,
  );
}

Map<String, dynamic> _$ProductToJson(Product instance) {
  Map<String, dynamic> json = {};
  if (instance.id != null) json['_id'] = instance.id;
  if (instance.name != null) json['name'] = instance.name;
  if (instance.publisherId != null) json['publisherId'] = instance.publisherId;
  if (instance.category != null) json['category'] = instance.category;
  if (instance.price != null) json['price'] = instance.price;
  if (instance.height != null) json['height'] = instance.height;
  if (instance.isActive != null) json['isActive'] = instance.isActive;
  if (instance.size != null) json['size'] = instance.size;
  if (instance.ram != null) json['ram'] = instance.ram;
  if (instance.storage != null) json['storage'] = instance.storage;
  if (instance.engine != null) json['engine'] = instance.engine;
  if (instance.engineType != null) json['engineType'] = instance.engineType;
  if (instance.transmission != null)
    json['transmission'] = instance.transmission;
  if (instance.color != null) json['color'] = instance.color;
  if (instance.releasedDate != null)
    json['releasedDate'] = instance.releasedDate;
  if (instance.importedDate != null)
    json['importedDate'] = instance.importedDate;
  if (instance.description != null) json['description'] = instance.description;
  if (instance.createdAt != null) json['createdAt'] = instance.createdAt;
  if (instance.productStatus != null)
    json['productStatus'] = instance.productStatus;
  if (instance.productStatusDate != null)
    json['productStatusDate'] = instance.productStatusDate;
  if (instance.updatedAt != null) json['updatedAt'] = instance.updatedAt;

  return json;
}
