part of '../models/link.dart';

Links _$LinksFromJson(Map<String, dynamic> json) {
  return Links(
    id: json['_id'] != null ? json['_id'] as String : null,
    type: json['type'] != null ? json['type'] as String : null,
    uri: json['uri'] != null ? json['uri'] as String : null,
  );
}

Map<String, dynamic> _$LinksToJson(Links instance) {
  Map<String, dynamic> json = {};
  if (instance.id != null) json['_id'] = instance.id;
  if (instance.type != null) json['type'] = instance.type;
  if (instance.uri != null) json['uri'] = instance.uri;

  return json;
}
