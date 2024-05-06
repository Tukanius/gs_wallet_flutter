import 'package:green_score/models/link.dart';
part '../parts/sale.dart';

class Sale {
  String? id;
  String? merchant;
  String? type;
  String? name;
  String? description;
  String? image;
  String? address;
  String? phone;
  String? phoneSecond;
  List<Links>? links;
  double? latitude;
  double? longitude;
  bool? isExpirity;
  String? expiryDate;
  int? saleAmount;
  double? saleTokenAmount;
  String? createdAt;
  String? updatedAt;

  Sale({
    this.id,
    this.name,
    this.createdAt,
    this.updatedAt,
    this.address,
    this.description,
    this.expiryDate,
    this.image,
    this.isExpirity,
    this.latitude,
    this.links,
    this.longitude,
    this.merchant,
    this.phone,
    this.phoneSecond,
    this.saleAmount,
    this.saleTokenAmount,
    this.type,
  });
  static $fromJson(Map<String, dynamic> json) => _$SaleFromJson(json);

  factory Sale.fromJson(Map<String, dynamic> json) => _$SaleFromJson(json);
  Map<String, dynamic> toJson() => _$SaleToJson(this);
}
