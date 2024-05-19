part of '../models/location_info.dart';

LocationInfo _$LocationInfoFromJson(Map<String, dynamic> json) {
  return LocationInfo(
    latitude: json['latitude'] != null ? json['latitude'] as num : null,
    longitude: json['longitude'] != null ? json['longitude'] as num : null,
    timestamp: json['timestamp'] != null ? json['timestamp'] as String : null,
    accuracy: json['accuracy'] != null ? json['accuracy'] as num : null,
    altitude: json['altitude'] != null ? json['altitude'] as num : null,
    altitudeAccuracy: json['altitudeAccuracy'] != null
        ? json['altitudeAccuracy'] as num
        : null,
    heading: json['heading'] != null ? json['heading'] as num : null,
    headingAccuracy:
        json['headingAccuracy'] != null ? json['headingAccuracy'] as num : null,
    speed: json['speed'] != null ? json['speed'] as num : null,
    speedAccuracy:
        json['speedAccuracy'] != null ? json['speedAccuracy'] as num : null,
  );
}

Map<String, dynamic> _$LocationInfoToJson(LocationInfo instance) {
  Map<String, dynamic> json = {};
  if (instance.latitude != null) json['latitude'] = instance.latitude;
  if (instance.longitude != null) json['longitude'] = instance.longitude;
  if (instance.timestamp != null) json['timestamp'] = instance.timestamp;
  if (instance.accuracy != null) json['accuracy'] = instance.accuracy;
  if (instance.altitude != null) json['altitude'] = instance.altitude;
  if (instance.altitudeAccuracy != null)
    json['altitudeAccuracy'] = instance.altitudeAccuracy;
  if (instance.heading != null) json['heading'] = instance.heading;
  if (instance.headingAccuracy != null)
    json['headingAccuracy'] = instance.headingAccuracy;
  if (instance.speed != null) json['speed'] = instance.speed;
  if (instance.speedAccuracy != null)
    json['speedAccuracy'] = instance.speedAccuracy;

  return json;
}
