part '../parts/bank.dart';

class Bank {
  // String? id;
  // String? userId;
  String? bankName;
  String? bankAccount;
  String? bankStatus;
  String? createdAt;
  String? updatedAt;
  Bank({
    // this.id,
    // this.userId,
    this.bankName,
    this.bankAccount,
    this.bankStatus,
    this.createdAt,
    this.updatedAt,
  });
  static $fromJson(Map<String, dynamic> json) => _$BankFromJson(json);

  factory Bank.fromJson(Map<String, dynamic> json) => _$BankFromJson(json);
  Map<String, dynamic> toJson() => _$BankToJson(this);
}
