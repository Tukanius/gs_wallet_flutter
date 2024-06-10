part '../parts/notify.dart';

class Notify {
  String? id;
  String? user;
  String? title;
  String? body;
  String? type;
  bool? seen;
  String? createdAt;
  String? updatedAt;

  Notify({
    this.id,
    this.user,
    this.title,
    this.body,
    this.type,
    this.seen,
    this.createdAt,
    this.updatedAt,
  });
  static $fromJson(Map<String, dynamic> json) => _$NotifyFromJson(json);

  factory Notify.fromJson(Map<String, dynamic> json) => _$NotifyFromJson(json);
  Map<String, dynamic> toJson() => _$NotifyToJson(this);
}
