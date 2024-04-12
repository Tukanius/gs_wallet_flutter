part '../parts/merchant.dart';

class Merchant {
  String? id;
  String? name;
  String? phone;
  String? address;
  String? registerNo;
  String? email;
  int? balance;
  String? createdAt;
  String? updatedAt;
  String? merchantStatus;
  String? merchantStatusDate;

  Merchant({
    this.id,
    this.name,
    this.phone,
    this.address,
    this.registerNo,
    this.email,
    this.balance,
    this.createdAt,
    this.updatedAt,
    this.merchantStatus,
    this.merchantStatusDate,
  });
  static $fromJson(Map<String, dynamic> json) => _$MerchantFromJson(json);

  factory Merchant.fromJson(Map<String, dynamic> json) =>
      _$MerchantFromJson(json);
  Map<String, dynamic> toJson() => _$MerchantToJson(this);
}
