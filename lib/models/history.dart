part '../parts/history.dart';

class History {
  String? id;
  String? type;
  String? objectId;
  String? objectType;
  num? amount;
  num? totalAmount;
  num? tokenAmount;
  String? currency;
  String? description;
  String? creditAccount;
  String? creditAccountName;
  String? creditAccountCurrency;
  String? debitAccount;
  String? debitAccountName;
  String? debitAccountCurrency;
  String? transactionStatus;
  String? transactionStatusDate;
  String? createdAt;
  String? updatedAt;

  History({
    this.id,
    this.amount,
    this.currency,
    this.description,
    this.createdAt,
    this.updatedAt,
    this.creditAccount,
    this.creditAccountCurrency,
    this.creditAccountName,
    this.debitAccount,
    this.debitAccountCurrency,
    this.debitAccountName,
    this.objectId,
    this.objectType,
    this.totalAmount,
    this.transactionStatus,
    this.transactionStatusDate,
    this.type,
    this.tokenAmount,
  });

  static $fromJson(Map<String, dynamic> json) => _$HistoryFromJson(json);

  factory History.fromJson(Map<String, dynamic> json) =>
      _$HistoryFromJson(json);
  Map<String, dynamic> toJson() => _$HistoryToJson(this);
}
