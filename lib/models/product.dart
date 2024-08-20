import 'package:green_score/models/images.dart';
import 'package:green_score/models/sale.dart';
import 'package:green_score/models/saleProducts.dart';
part '../parts/product.dart';

class Product {
  String? id;
  String? name;
  String? code;
  String? barcode;
  String? description;
  int? price;
  List<Images>? images;
  String? createdAt;
  String? updatedAt;
  Sale? sale;
  SaleProduct? saleProduct;

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
    this.sale,
    this.saleProduct,
  });
  static $fromJson(Map<String, dynamic> json) => _$ProductFromJson(json);

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);
  Map<String, dynamic> toJson() => _$ProductToJson(this);
}
