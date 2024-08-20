part of '../models/images.dart';

Images _$ImagesFromJson(Map<String, dynamic> json) {
  return Images(
    id: json['_id'] != null ? json['_id'] as String : null,
    url: json['url'] != null ? json['url'] as String : null,
    thumbnail: json['thumbnail'] != null ? json['thumbnail'] as String : null,
    blurhash: json['blurhash'] != null ? json['blurhash'] as String : null,
    width: json['width'] != null ? json['width'] as int : null,
    height: json['height'] != null ? json['height'] as int : null,
    isUsed: json['isUsed'] != null ? json['isUsed'] as bool : null,
    createdAt: json['createdAt'] != null ? json['createdAt'] as String : null,
    updatedAt: json['updatedAt'] != null ? json['updatedAt'] as String : null,
  );
}

Map<String, dynamic> _$ImagesToJson(Images instance) {
  Map<String, dynamic> json = {};
  if (instance.id != null) json['_id'] = instance.id;
  if (instance.url != null) json['url'] = instance.url;
  if (instance.thumbnail != null) json['thumbnail'] = instance.thumbnail;
  if (instance.blurhash != null) json['blurhash'] = instance.blurhash;
  if (instance.width != null) json['width'] = instance.width;
  if (instance.height != null) json['height'] = instance.height;
  if (instance.isUsed != null) json['isUsed'] = instance.isUsed;
  if (instance.createdAt != null) json['createdAt'] = instance.createdAt;
  if (instance.updatedAt != null) json['updatedAt'] = instance.updatedAt;

  return json;
}
