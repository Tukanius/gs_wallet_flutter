part of '../models/general.dart';

General _$GeneralFromJson(Map<String, dynamic> json) {
  return General(
    bank: json['bank'] != null
        ? (json['bank'] as List).map((e) => Bank.fromJson(e)).toList()
        : null,
  );
}

Map<String, dynamic> _$GeneralToJson(General instance) {
  Map<String, dynamic> json = {};

  if (instance.bank != null) json['bank'] = instance.bank;

  return json;
}
