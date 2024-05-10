part '../parts/product_image.dart';

class ProductImage {
  String? id;
  String? image;
  int? sort;
  String? createdAt;
  String? updatedAt;
  ProductImage({
    this.id,
    this.image,
    this.sort,
    this.createdAt,
    this.updatedAt,
  });

  static $fromJson(Map<String, dynamic> json) => _$ProductImageFromJson(json);

  factory ProductImage.fromJson(Map<String, dynamic> json) =>
      _$ProductImageFromJson(json);
  Map<String, dynamic> toJson() => _$ProductImageToJson(this);
}
