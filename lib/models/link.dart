part '../parts/link.dart';

class Links {
  String? id;
  String? type;
  String? uri;

  Links({
    this.id,
    this.type,
    this.uri,
  });

  static $fromJson(Map<String, dynamic> json) => _$LinksFromJson(json);

  factory Links.fromJson(Map<String, dynamic> json) => _$LinksFromJson(json);
  Map<String, dynamic> toJson() => _$LinksToJson(this);
}
