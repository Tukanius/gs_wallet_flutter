import 'package:green_score/models/invoice.dart';

part '../parts/deposit.dart';

class Deposit {
  int? amount;
  String? paymentMethod;
  String? id;
  String? user;
  String? method;
  String? currency;
  String? description;
  String? paymentStatus;
  Invoice? invoice;
  String? paymentStatusDate;
  String? createdAt;
  String? updatedAt;

  Deposit({
    this.amount,
    this.paymentMethod,
    this.id,
    this.user,
    this.invoice,
    this.method,
    this.currency,
    this.description,
    this.paymentStatus,
    this.paymentStatusDate,
    this.createdAt,
    this.updatedAt,
  });

  static $fromJson(Map<String, dynamic> json) => _$DepositFromJson(json);

  factory Deposit.fromJson(Map<String, dynamic> json) =>
      _$DepositFromJson(json);
  Map<String, dynamic> toJson() => _$DepositToJson(this);
}
