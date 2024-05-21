import 'package:freezed_annotation/freezed_annotation.dart';

part 'photo_model.freezed.dart';

part 'photo_model.g.dart';

@freezed
class PhotoModel with _$PhotoModel {
  @JsonSerializable()
  factory PhotoModel({
    @Default(0) int albumId,
    @Default(0) int id,
    @Default('') String title,
    @Default('') String url,
    @Default('') String thumbnailUrl,
  }) = _PhotoModel;

  factory PhotoModel.fromJson(Map<String, dynamic> json) =>
      _$PhotoModelFromJson(json);
}
