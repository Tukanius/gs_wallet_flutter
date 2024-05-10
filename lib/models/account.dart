part '../parts/account.dart';

class Account {
  String? id;
  String? ownerType;
  String? type;
  String? code;
  String? name;
  String? qrCode;
  String? currency;
  String? pubKey;
  String? txHash;
  int? balanceAmount;
  int? holdAmount;
  String? createdAt;
  String? updatedAt;

  Account({
    this.id,
    this.ownerType,
    this.type,
    this.code,
    this.name,
    this.qrCode,
    this.currency,
    this.pubKey,
    this.txHash,
    this.balanceAmount,
    this.holdAmount,
    this.createdAt,
    this.updatedAt,
  });
  static $fromJson(Map<String, dynamic> json) => _$AccountFromJson(json);

  factory Account.fromJson(Map<String, dynamic> json) =>
      _$AccountFromJson(json);
  Map<String, dynamic> toJson() => _$AccountToJson(this);
}
