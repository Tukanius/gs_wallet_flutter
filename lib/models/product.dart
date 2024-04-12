part '../parts/product.dart';

class Product {
  String? id;
  String? publisherId;
  String? name;
  String? category;
  int? price;
  String? height;
  bool? isActive;
  String? size;
  String? ram;
  String? storage;
  String? engine;
  String? engineType;
  String? transmission;
  String? color;
  String? releasedDate;
  String? importedDate;
  String? description;
  String? createdAt;
  String? productStatus;
  String? productStatusDate;
  String? updatedAt;

  Product({
    this.id,
    this.publisherId,
    this.name,
    this.category,
    this.price,
    this.height,
    this.isActive,
    this.size,
    this.ram,
    this.storage,
    this.engine,
    this.engineType,
    this.transmission,
    this.color,
    this.releasedDate,
    this.importedDate,
    this.description,
    this.createdAt,
    this.productStatus,
    this.productStatusDate,
    this.updatedAt,
  });
  static $fromJson(Map<String, dynamic> json) => _$ProductFromJson(json);

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);
  Map<String, dynamic> toJson() => _$ProductToJson(this);
}
