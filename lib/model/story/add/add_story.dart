import 'dart:convert';

AddStory addStoryFromJson(String str) => AddStory.fromJson(json.decode(str));

String addStoryToJson(AddStory data) => json.encode(data.toJson());

class AddStory {
  bool error;
  String message;

  AddStory({
    required this.error,
    required this.message,
  });

  factory AddStory.fromJson(Map<String, dynamic> json) => AddStory(
    error: json["error"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "error": error,
    "message": message,
  };
}
