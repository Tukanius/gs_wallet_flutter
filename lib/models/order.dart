part '../parts/order.dart';

class Order {
  String? id;
  String? iv;
  // String? merchant;
  String? code;
  String? type;
  String? paymentMethod;
  String? qrcode;
  int? totalAmount;
  int? cashAmount;
  int? cardAmount;
  int? payAmount;
  int? saleTokenAmount;
  bool? isSale;
  String? orderStatus;
  String? orderStatusDate;
  String? createdAt;
  String? updatedAt;

  Order({
    this.id,
    this.iv,
    this.cardAmount,
    this.cashAmount,
    this.code,
    this.createdAt,
    this.isSale,
    // this.merchant,
    this.orderStatus,
    this.orderStatusDate,
    this.payAmount,
    this.paymentMethod,
    this.qrcode,
    this.saleTokenAmount,
    this.totalAmount,
    this.type,
    this.updatedAt,
  });

  static $fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);

  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);
  Map<String, dynamic> toJson() => _$OrderToJson(this);
}
