part '../parts/location_info.dart';

class LocationInfo {
  num? latitude;
  num? longitude;
  String? timestamp;
  num? accuracy;
  num? altitude;
  num? altitudeAccuracy;
  num? heading;
  num? headingAccuracy;
  num? speed;
  num? speedAccuracy;

  LocationInfo({
    this.latitude,
    this.longitude,
    this.timestamp,
    this.accuracy,
    this.altitude,
    this.altitudeAccuracy,
    this.heading,
    this.headingAccuracy,
    this.speed,
    this.speedAccuracy,
  });
  static $fromJson(Map<String, dynamic> json) => _$LocationInfoFromJson(json);

  factory LocationInfo.fromJson(Map<String, dynamic> json) =>
      _$LocationInfoFromJson(json);
  Map<String, dynamic> toJson() => _$LocationInfoToJson(this);
}
