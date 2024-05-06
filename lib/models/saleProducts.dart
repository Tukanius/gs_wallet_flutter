part '../parts/saleProducts.dart';

class SaleProduct {
  String? id;
  String? merchant;
  String? sale;
  String? name;
  String? product;
  int? saleAmount;
  double? tokenAmount;
  String? createdAt;
  String? updatedAt;

  SaleProduct({
    this.id,
    this.sale,
    this.name,
    this.product,
    this.createdAt,
    this.updatedAt,
    this.merchant,
    this.saleAmount,
    this.tokenAmount,
  });
  static $fromJson(Map<String, dynamic> json) => _$SaleProductFromJson(json);

  factory SaleProduct.fromJson(Map<String, dynamic> json) =>
      _$SaleProductFromJson(json);
  Map<String, dynamic> toJson() => _$SaleProductToJson(this);
}
