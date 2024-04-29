import 'package:green_score/models/link.dart';

part '../parts/merchant.dart';

class Merchant {
  String? id;
  String? type;
  String? name;
  String? image;
  String? registerNo;
  String? taxNo;
  String? email;
  String? phone;
  String? phoneSecond;
  String? address;
  double? latitude;
  double? longitude;
  List<Links>? links;
  String? createdAt;
  String? updatedAt;

  Merchant({
    this.id,
    this.name,
    this.phone,
    this.address,
    this.registerNo,
    this.email,
    this.createdAt,
    this.updatedAt,
    this.image,
    this.latitude,
    this.longitude,
    this.phoneSecond,
    this.taxNo,
    this.type,
    this.links,
  });
  static $fromJson(Map<String, dynamic> json) => _$MerchantFromJson(json);

  factory Merchant.fromJson(Map<String, dynamic> json) =>
      _$MerchantFromJson(json);
  Map<String, dynamic> toJson() => _$MerchantToJson(this);
}
