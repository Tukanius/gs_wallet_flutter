part '../parts/invoice.dart';

class Invoice {
  int? amount;
  String? paymentMethod;
  String? id;
  String? user;
  String? invoice;
  String? method;
  String? currency;
  String? description;
  String? paymentStatus;
  String? paymentStatusDate;
  String? createdAt;
  String? updatedAt;

  Invoice({
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

  static $fromJson(Map<String, dynamic> json) => _$InvoiceFromJson(json);

  factory Invoice.fromJson(Map<String, dynamic> json) =>
      _$InvoiceFromJson(json);
  Map<String, dynamic> toJson() => _$InvoiceToJson(this);
}
