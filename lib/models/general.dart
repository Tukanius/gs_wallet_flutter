import 'package:green_score/models/bank.dart';

part '../parts/general.dart';

class General {
  List<Bank>? bank;

  General({
    this.bank,
  });

  static $fromJson(Map<String, dynamic> json) => _$GeneralFromJson(json);

  factory General.fromJson(Map<String, dynamic> json) =>
      _$GeneralFromJson(json);
  Map<String, dynamic> toJson() => _$GeneralToJson(this);
}
