import 'package:freezed_annotation/freezed_annotation.dart';
part 'story_detail.g.dart';
part 'story_detail.freezed.dart';

@freezed
class StoryDetail with _$StoryDetail {
  const factory StoryDetail({
    required bool error,
    required String message,
    @JsonKey(name: "story") required Story story,
  }) = _StoryDetail;

  factory StoryDetail.fromJson(Map<String, dynamic> json) =>
      _$StoryDetailFromJson(json);
}

@freezed
class Story with _$Story {
  const factory Story({
    required String id,
    required String name,
    required String description,
    required String photoUrl,
    required DateTime createdAt,
    double? lat,
    double? lon,
  }) = _Story;

  factory Story.fromJson(Map<String, dynamic> json) => _$StoryFromJson(json);
}
