import 'package:freezed_annotation/freezed_annotation.dart';
part 'story_list.freezed.dart';
part 'story_list.g.dart';

@freezed
class StoryList with _$StoryList {
  const factory StoryList({
    required bool error,
    required String message,
    @JsonKey(name: 'listStory') required List<ListStory> listStory,
  }) = _StoryList;

  factory StoryList.fromJson(Map<String, dynamic> json) =>
      _$StoryListFromJson(json);
}

@freezed
class ListStory with _$ListStory {
  const factory ListStory({
    required String id,
    required String name,
    required String description,
    required String photoUrl,
    required DateTime createdAt,
    double? lat,
    double? lon,
  }) = _ListStory;

  factory ListStory.fromJson(Map<String, dynamic> json) =>
      _$ListStoryFromJson(json);
}
