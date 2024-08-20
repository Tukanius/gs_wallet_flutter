part '../parts/images.dart';

class Images {
  String? id;
  String? url;
  String? thumbnail;
  String? blurhash;
  int? width;
  int? height;
  bool? isUsed;
  String? createdAt;
  String? updatedAt;
  Images({
    this.id,
    this.url,
    this.thumbnail,
    this.blurhash,
    this.width,
    this.height,
    this.isUsed,
    this.createdAt,
    this.updatedAt,
  });

  static $fromJson(Map<String, dynamic> json) => _$ImagesFromJson(json);

  factory Images.fromJson(Map<String, dynamic> json) => _$ImagesFromJson(json);
  Map<String, dynamic> toJson() => _$ImagesToJson(this);
}
