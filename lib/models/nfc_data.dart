part '../parts/nfc_data.dart';

class NfcData {
  String? nfcCode;

  NfcData({
    this.nfcCode,
  });
  static $fromJson(Map<String, dynamic> json) => _$NfcDataFromJson(json);

  factory NfcData.fromJson(Map<String, dynamic> json) =>
      _$NfcDataFromJson(json);
  Map<String, dynamic> toJson() => _$NfcDataToJson(this);
}
