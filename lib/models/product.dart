import 'package:green_score/models/product_image.dart';
part '../parts/product.dart';

class Product {
  String? id;
  String? name;
  String? code;
  String? barcode;
  String? description;
  int? price;
  String? createdAt;
  String? updatedAt;
  List<ProductImage>? images;

  Product({
    this.id,
    this.name,
    this.price,
    this.description,
    this.createdAt,
    this.updatedAt,
    this.barcode,
    this.code,
    this.images,
  });
  static $fromJson(Map<String, dynamic> json) => _$ProductFromJson(json);

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);
  Map<String, dynamic> toJson() => _$ProductToJson(this);
}
