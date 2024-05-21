// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'photo_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_PhotoModel _$_$_PhotoModelFromJson(Map<String, dynamic> json) {
  return _$_PhotoModel(
    albumId: json['albumId'] as int? ?? 0,
    id: json['id'] as int? ?? 0,
    title: json['title'] as String? ?? '',
    url: json['url'] as String? ?? '',
    thumbnailUrl: json['thumbnailUrl'] as String? ?? '',
  );
}

Map<String, dynamic> _$_$_PhotoModelToJson(_$_PhotoModel instance) =>
    <String, dynamic>{
      'albumId': instance.albumId,
      'id': instance.id,
      'title': instance.title,
      'url': instance.url,
      'thumbnailUrl': instance.thumbnailUrl,
    };
