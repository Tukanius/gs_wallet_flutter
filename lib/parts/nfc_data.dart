part of '../models/nfc_data.dart';

NfcData _$NfcDataFromJson(Map<String, dynamic> json) {
  return NfcData(
    nfcCode: json['nfcCode'] != null ? json['nfcCode'] as String : null,
  );
}

Map<String, dynamic> _$NfcDataToJson(NfcData instance) {
  Map<String, dynamic> json = {};

  if (instance.nfcCode != null) json['nfcCode'] = instance.nfcCode;

  return json;
}
